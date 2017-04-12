class InvestigationGroup < ApplicationRecord
#<<<<<<< HEAD
	#attr_accessor :name, :create_date, :description
#=======

#>>>>>>> 793ab9efb00af13e2b7d3a6d0b8228970e5a42a3
  has_many :students

	has_many :teacher_investigation_groups
	has_many :teachers, through: :teacher_investigation_groups

	has_many :contributions

	has_many :tag_investigation_groups
	has_many :tags, through: :tag_investigation_groups

	has_many :events

	has_many :history_groups

  default_scope {order("investigation_groups.name ASC")}
  scope :sort_by_name, -> (ord) {order("investigation_groups.name #{ord}")}
  scope :sort_by_create_date, -> (ord) {order("investigation_groups.created_at #{ord}")}

  validates :name, :create_date, :presence => true
  validates :name, :length => { :maximum => 100, :too_long => "%{count} Demasiados caracteres" }
  validates :name, :length => { :minimum => 5, :too_short => "%{count} Muy pocos caracteres" }
  validates :description, :length => { :maximum => 200, :too_long => "%{count} Demasiados caracteres" }

 mount_uploader :image, ImageUploader

#busca grupos de investigacion por eventos
  def self.load_groups(id)
	   includes(:events).paginate(:page => page,:per_page => per_page)
  end
#busca grupos de investigacion por tags
  def self.load_investigation_groups_tags(**args)
    includes(:tags).paginate(:page => args[:page],:per_page => args[:per_page])
  end
#busca grupo d einvestigacion por un tag en especifico
  def self.investigation_group_by_tag_name(name)
    tag = Tag.find_by_name( name ).id.to_s
    load_investigation_groups_tags.where( tags: { id: tag } )
  end

end
