class Event < ApplicationRecord


	has_many :event_students
  has_many :students, through: :event_students

  has_many :event_teachers
  has_many :teachers, through: :event_teachers

  belongs_to :investigation_group

  scope :sort_by_create_date, -> (ord) {order("Events.created_at #{ord}")}

  validates :name, :date_time, :presence => true
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
    includes(:name,:date_time,:description, :investigation_group)
      .paginate(:page => args[:page],:per_page => args[:per_page])
  end

  def self.events_by_name(name,**args)
    load_groups(args)
      .where("event.name LIKE ?", "#{name.downcase}%")
  end

  def self.event_by_id(id)
    includes(:name,:date_time,:description)
      .find_by_id(:id)
  end

  def self.event_by_investigationGroup(group_id,**ars)
    load_groups(args)
      .where("event.investigation_group_id LIKE ?", "#{group_id}%")
  end

  def self.events_by_ids(ids,**args)
    load_groups(args)
      .where(event: {
        id: ids
      })
  end
end
