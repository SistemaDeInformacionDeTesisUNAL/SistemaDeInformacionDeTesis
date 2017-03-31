class InvestigationGroup < ApplicationRecord

  has_many :students

	has_many :teacher_investigation_groups
	has_many :teachers, through: :teacher_investigation_groups

	has_many :contributions

	has_many :tag_investigation_groups
	has_many :tags, through: :tag_investigation_groups

	has_many :events

	has_many :history_groups

  default_scope {order("InvestigationGroups.name ASC")}
  scope :sort_by_name, -> (ord) {order("InvestigationGroups.name #{ord}")}
  scope :sort_by_create_date, -> (ord) {order("InvestigationGroups.created_at #{ord}")}

  validates :name, :create_date, :presence => true
  validates :name, :length => { :maximum => 100, :too_long => "%{count} Demasiados caracteres" }
  validates :name, :length => { :minimum => 5, :too_short => "%{count} Muy pocos caracteres" }
  validates :description, :length => { :maximum => 200, :too_long => "%{count} Demasiados caracteres" }
  #validates :comprobar_fecha

  #Fecha de la creación del grupo de investigación no puede ser mayor que la del día actual
  def comprobar_fecha
    if :create_date > Date.today
      #Añadimos error
      errors.add(:create_date, "Fecha incorrecta")
    end
  end

  def self.load_groups(**args)
    includes(:name,:create_date,:description)
      .paginate(:page => args[:page],:per_page => args[:per_page])
  end

    def self.groups_by_name(name,**args)
    load_groups(args)
      .where("InvestigationGroups.name LIKE ?", "#{name.downcase}%")
  end

    def self.group_by_id(id)
    includes(:name,:create_date,:description)
      .find_by_id(:id)
  end

  def self.groups_by_ids(ids,**args)
    load_groups(args)
      .where(InvestigationGroups: {
        id: ids
      })
  end
end
