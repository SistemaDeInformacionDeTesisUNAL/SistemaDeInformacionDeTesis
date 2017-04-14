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

  validates :name, :publication_date, :presence => true
  validates :name, :length => { :maximum => 100, :too_long => "%{count} Demasiados caracteres" }
  validates :name, :length => { :minimum => 5, :too_short => "%{count} Muy pocos caracteres" }
  validates :description, :length => { :maximum => 200, :too_long => "%{count} Demasiados caracteres" }
  validates :state, inclusion: { in: states.keys }



  #Carga todos las contribuciones de acuerdo a sus tags
  def self.load_contributions_tags(**args)
    includes(:tags).paginate(:page => args[:page],:per_page => args[:per_page])
  end

  def self.lodad_contribution_groups(**args)
    includes(:investigation_group).paginate(:page => args[:page],:per_page => args[:per_page])
  end

  #Muestra las ubicaciones de una contribucion
	def self.ubication_by_contribution(**args)
		Ubication.load_ubications.where( contributions: { id: args[:ids] } )
	end

  #Muestra las contribuciones que contienen un tag
  def self.contribution_by_tag_name(**args)
    if !args[:tag].blank? && !args[:group].blank? then
      includes(:investigation_group, :tags).where( investigation_groups: { id: args[:group]}, tags: { id: args[:tag]} ).paginate(:page => args[:page],:per_page => args[:per_page])
    else
      if !args[:tag].blank? then
        load_contributions_tags.where( tags: { id: args[:tag]} ).paginate(:page => args[:page],:per_page => args[:per_page])
      else
        if !args[:group].blank? then
          includes(:investigation_group).where( investigation_groups: { id: args[:group]} ).paginate(:page => args[:page],:per_page => args[:per_page])
        else
          includes(:investigation_group).paginate(:page => args[:page],:per_page => args[:per_page])
        end
      end
    end
  end

  #Devuelve los colaboradores de una contribucion
  def self.user_by_contribution(**args)
    stud = Student.load_contributions.where( contributions: { id: args[:ids] } )
    teach = Teacher.load_contributions.where( contributions: { id: args[:ids] } )
    return stud + teach
  end

  #Muestra las ubicaciones de una contribucion
  def self.ubications(**args)
  	Ubication.load_ubications.where( contributions: { id: args[:ids] } ).paginate(:page => args[:page],:per_page => args[:per_page])
  end

  #Cuenta cuantas contribuciones hay en total, necesaria para hacer el indice para separar por paginas
  def self.count
    Contribution.all.count
  end
  #lista las contribuciones por grupo de investigacion
   def self.load_contributions(**args)
     includes(:investigation_group).paginate(:page => args[:page],:per_page => args[:per_page])
     #grpc= InvestigationGroup.contribution_by_group.where(contributions: {id: args[:ids]})
 end
end
