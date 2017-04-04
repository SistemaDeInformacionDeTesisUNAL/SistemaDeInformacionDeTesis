class Event < ApplicationRecord

  has_many :event_students
  has_many :students, through: :event_students

  has_many :event_teachers
  has_many :teachers, through: :event_teachers

  belongs_to :investigation_group

  scope :sort_by_create_date, -> (ord) {order("Events.created_at #{ord}")}

  #validates :name, :date_time, :presence => true
  validates :name, :presence => true
  validates :name, :uniqueness => true
  validates :name, :length => { :maximum => 45, :too_long => "%{count} Demasiados caracteres" }
  validates :name, :length => { :minimum => 5, :too_short => "%{count} Muy pocos caracteres" }
  validates :description, :length => { :maximum => 200, :too_long => "%{count} Demasiados caracteres" }
  #validates :datetime, :comprobar_fecha

  #Fecha de la creación del evento no puede ser menor que la del día actual
  def comprobar_fecha
    if :date_time < Date.today
      #Añadimos error
      errors.add(:date_time, "Fecha incorrecta")
    end
  end

  def self.load_events(**args)
    includes(:investigation_group).paginate(:page => args[:page],:per_page => args[:per_page])
  end


  def self.event_by_id(id,**args)
    includes(:name,:date_time,:description).find_by_id(id)
	
  end


  def self.investigationGroup_by_event(event_id)

	InvestigationGroup.find_by_id( Event.find_by_id(event_id).investigation_group_id)
	
  end

end
