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

  def self.load_contributions_tags(**args)
    includes(:tags).paginate(:page => args[:page],:per_page => args[:per_page])
  end

  #Muestra las ubicaciones de una contribucion
	def self.ubication_by_contribution(**args)
		Ubication.load_ubications.where( contributions: { id: args[:ids] } )
	end

  #Muestra las contribuciones que contienen un tag
  def self.contribution_by_tag_name(name)
    tag = Tag.find_by_name( name ).id.to_s
    load_contributions_tags.where( tags: { id: tag } )
  end

  #Devuelve los colaboradores de una contribucion
  def self.user_by_contribution(**args)
    stud = Student.load_contributions.where( contributions: { id: args[:ids] } )
    teach = Teacher.load_contributions.where( contributions: { id: args[:ids] } )
    return stud + teach
  end

  #No se ha probado
  def self.contribution_by_id(contribution_id)
    includes(:investigation_group).find_by_id(contribution_id)
  end

end
