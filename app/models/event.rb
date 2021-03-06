class Event < ApplicationRecord

  has_many :event_students, dependent: :destroy
  has_many :students, through: :event_students

  has_many :event_teachers, dependent: :destroy
  has_many :teachers, through: :event_teachers

  belongs_to :investigation_group

  scope :sort_by_create_date, -> (ord) {order("Events.created_at #{ord}")}

  validates :name, :uniqueness => true
  validates :name, :length => { :maximum => 45, :too_long => "%{count} Demasiados caracteres" }
  validates :name, :length => { :minimum => 5, :too_short => "%{count} Muy pocos caracteres" }
  validates :description, :length => { :maximum => 200, :too_long => "%{count} Demasiados caracteres" }
  validates :start_time, presence: true
  validates :end_time, presence: true

  def self.load_events(**args)
    includes(:investigation_group)
  end

  def self.myEvents(**args)
    @misEventos=[]
    EventStudent.where(student_id:args[:id]).each do |eventStu|
      @misEventos<<Event.find(eventStu.event_id)
    end
    return @misEventos
  end

end
