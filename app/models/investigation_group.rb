class InvestigationGroup < ApplicationRecord
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

  def self.count
    InvestigationGroup.all.count
  end

  def self.load_groups(**args)
	   includes(:events).paginate(:page => args[:page],:per_page => args[:per_page])
  end

end
