class Contribution < ActiveRecord::Base

  has_many :user_contributions
  has_many :students, through: :user_contributions
  has_many :teachers, through: :user_contributions

  belongs_to :investigation_group

  has_many :ubications

  has_many :tag_contributions
  has_many :tags, through: :tag_contributions

  before_destroy :destroyContributionFromTag
  after_create :create_user_contribution


  enum state: {Aproved: 0, Rejected: 1, Progress: 2}

  mount_uploader :file, FileUploader

  validates :name, :presence => true
  validates :name, :length => { :maximum => 100, :too_long => "%{count} Demasiados caracteres" }
  validates :name, :length => { :minimum => 5, :too_short => "%{count} Muy pocos caracteres" }
  validates :description, :length => { :maximum => 200, :too_long => "%{count} Demasiados caracteres" }
  validates :state, inclusion: { in: states.keys }

  def create_user_contribution
    UserContribution.create_with( userable_type: Student, userable_id: Student.last, contribution_id: Contribution.last.id+1 ).find_or_create_by(id: Contribution.last.id+1)
  end
#aún en prueba
def destroyContributionFromTag
  TagContribution.where(contribution_id: :id).destroy_all
end

  #Carga todos las contribuciones de acuerdo a sus tags
  def self.load_contributions_tags(**args)
    includes(:tags)
  end

  def self.lodad_contribution_groups(**args)
    includes(:investigation_group)
  end

  #Muestra las ubicaciones de una contribucion
	def self.ubication_by_contribution(**args)
		Ubication.load_ubications.where( contributions: { id: args[:ids] } )
	end

  #Muestra las contribuciones que contienen un tag
  def self.contribution_by_tag_name(**args)
    if !args[:tag].blank? && !args[:group].blank? && !args[:state].blank? then
      includes(:investigation_group, :tags).where( investigation_groups: { id: args[:group]}, tags: { id: args[:tag]}, :state => args[:state] )
    else
        if !args[:tag].blank? && !args[:group].blank? && args[:state].blank?  then
          includes(:investigation_group, :tags).where( investigation_groups: { id: args[:group]}, tags: { id: args[:tag]} )
        else
          if !args[:tag].blank? && !args[:state].blank? && args[:group].blank? then
            includes(:tags).where( tags: { id: args[:tag]},:state => args[:state] )
          else
            if !args[:group].blank? && !args[:state].blank? && args[:tag].blank?then
              includes(:investigation_group ).where( investigation_groups: { id: args[:group]}, :state => args[:state] )
            else
      if !args[:tag].blank? then
        load_contributions_tags.where( tags: { id: args[:tag]} )
      else
        if !args[:group].blank? then
          includes(:investigation_group).where( investigation_groups: { id: args[:group]} )
        else
          if !args[:state].blank? then
            load_contributions.where(:state => args[:state])

          else
              includes(:investigation_group)
            end
          end
        end
          end
        end
      end
    end
  end

  #Estudiantes de una contribución
  def self.students(**args)
    Student.load_contributions.where( contributions: { id: args[:contribution_id] } )
  end
  #Profesores de una contribución
  def self.teachers(**args)
    Teacher.load_contributions.where( contributions: { id: args[:contribution_id] } )
  end



  #Muestra las ubicaciones de una contribucion
  def self.ubications(**args)
  	Ubication.load_ubications.where( contributions: { id: args[:ids] } )
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
