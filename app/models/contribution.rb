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

  def self.load_contributions(**args)
    includes(:ubication).paginate(:page => args[:page],:per_page => args[:per_page])
  end

  #Muestra las ubicaciones de una contribucion
	def self.ubication_by_contribution(ids,page = 1, per_page = 10)
		load_contributions(page,per_page).where(contributions:{ id: ids})
	end

  #Devuelve los colaboradores de una contribucion
  def self.user_by_contribution(contribution_id,page=1, per_page=3)
    Contribution.find_by_id(contribution_id).user_contribution_ids
  end

  #Devuelve los tags de una contribucion
  def self.tags_by_contribution(contribution_id, page=1, per_page=3)
    Contribution.find_by_id(contribution_id).tag_ids.each do |t|
  		puts "Id tag:" + t.to_s
  		puts "Tag name:" + Tag.find_by_id(t).name
  		puts "description:" + Tag.find_by_id(t).description
  	end
  end

  def self.contribution_by_id(contribution_id)
    includes(:investigation_group).find_by_id(contribution_id)
  end

end
