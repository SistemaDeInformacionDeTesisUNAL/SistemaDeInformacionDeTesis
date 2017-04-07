class Event < ApplicationRecord

  has_many :event_students
  has_many :students, through: :event_students

  has_many :event_teachers
  has_many :teachers, through: :event_teachers

  belongs_to :investigation_group

  scope :sort_by_create_date, -> (ord) {order("Events.created_at #{ord}")}

  validates :name, :uniqueness => true
  validates :name, :length => { :maximum => 45, :too_long => "%{count} Demasiados caracteres" }
  validates :name, :length => { :minimum => 5, :too_short => "%{count} Muy pocos caracteres" }
  validates :description, :length => { :maximum => 200, :too_long => "%{count} Demasiados caracteres" }


  #No se han probado
  def self.load_events(**args)
    includes(:investigation_group).paginate(:page => args[:page],:per_page => args[:per_page])
  end


  def self.event_by_id(**args)
    includes(:name,:date_time,:description).find_by_id(args[:id])
  end


  def self.investigationGroup_by_event(event_id)

	InvestigationGroup.find_by_id( Event.find_by_id(event_id).investigation_group_id)

  end

end
