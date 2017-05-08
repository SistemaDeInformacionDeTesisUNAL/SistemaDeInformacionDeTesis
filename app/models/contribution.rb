class Contribution < ActiveRecord::Base

  has_many :user_contributions
  has_many :students, through: :user_contributions
  has_many :teachers, through: :user_contributions

  belongs_to :investigation_group

  has_many :ubications

  has_many :tag_contributions
  has_many :tags, through: :tag_contributions

  enum state: {Aproved: 0, Rejected: 1, Progress: 2}

  mount_uploader :file, FileUploader

  validates :name, :presence => true
  validates :name, :length => { :maximum => 100, :too_long => "%{count} Demasiados caracteres" }
  validates :name, :length => { :minimum => 5, :too_short => "%{count} Muy pocos caracteres" }
  validates :description, :length => { :maximum => 200, :too_long => "%{count} Demasiados caracteres" }
  validates :state, inclusion: { in: states.keys }

  #Carga todos las contribuciones de acuerdo a sus tags
  def self.load_contributions_tags(**args)
    includes(:tags)
  end

  def self.contributions(**args)
    includes(:investigation_group, :tags)
  end

  def self.lodad_contribution_groups(**args)
    includes(:investigation_group)
  end

  #Estudiantes de una contribución
  def self.students(**args)
    Student.load_contributions.where( contributions: { id: args[:id] } )
  end
  #Profesores de una contribución
  def self.teachers(**args)
    Teacher.load_contributions.where( contributions: { id: args[:id] } )
  end

  #Muestra las ubicaciones de una contribucion
  def self.ubications(**args)
  	Ubication.load_ubications.where( contributions: { id: args[:ids] } )
  end

  def self.user_contribution(**args)
    UserContribution.where(userable_type: args[:type], userable_id: args[:ids], contribution_id: args[:contr] )
  end
  #Cuenta cuantas contribuciones hay en total, necesaria para hacer el indice para separar por paginas
  def self.count
    Contribution.all.count
  end
  #lista las contribuciones por grupo de investigacion
  def self.load_contributions(**args)
    includes(:investigation_group)
    #grpc= InvestigationGroup.contribution_by_group.where(contributions: {id: args[:ids]})
  end
end
