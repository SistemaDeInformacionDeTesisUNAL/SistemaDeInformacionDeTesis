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

  #validates :name, :create_date, :presence => true
  validates :name, :presence => true
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
  #def self.load_groups(page = 1, per_page = 10)
    #includes(:name,:create_date,:description).paginate(:page => args[:page],:per_page => args[:per_page])
	includes(:events).paginate(:page => args[:page],:per_page => args[:per_page])
	#includes(:events).paginate(:page => page,:per_page => per_page)
  end

    #def self.groups_by_name(name,**args)
    #load_groups(args).where("investigation_groups.name LIKE ?", "#{name.downcase}%")
  #end
	
	#def self.event_by_investigation_group(event_id)
	def self.event_by_investigation_group(id)
	#	includes(:events).select("investigation_groups.*").where("investigation:group.event_id LIKE ?", "#{event_id}%")
	#includes(:events).find_by_id(id)
	end
	
    #def self.group_by_id(investigation_group_id)
    #includes(:name,:create_date,:description).find_by_id(:id)
	#includes(:events).find_by_id(:investigation_group_id)
  #end
  
  def self.group_by_id(group_id)
	includes(:events).find_by_id(group_id).find(event.all)
  end

  def self.groups_by_ids(id,**args)
    load_groups(args).where(investigation_groups: {id: id})
  end
  
  def self.groups_by_id(ids,page =1, per_page=10)
	#load_groups(page,per_page).where(investigation_groups:{id: ids})
  end
  
  def self.event_by_investigationGroup(group_id,page=1, per_page=3)
    Event.find_by_id( InvestigationGroup.find_by_id(group_id).event_ids)
	#.paginate(:page => page, :per_page => per_page)
	#Event.find_by_id( InvestigationGroup.find_by_id(group_id).event_ids)
  end
  
end
