class Event < ApplicationRecord
	attr_accessor :name, :datetime, :description

	has_many :event_students
  has_many :students, through: :event_students

  has_many :event_teachers
  has_many :teachers, through: :event_teachers

  belongs_to :investigation_group

  validates :name, :datetime, :presence => true
  validates :name, :uniqueness => true
  validates :name, :length => { :maximum => 45, :too_long => "%{count} Demasiados caracteres" }
  validates :name, :length => { :minimum => 5, :too_short => "%{count} Muy pocos caracteres" }
  validates :description, :length => { :maximum => 200, :too_long => "%{count} Demasiados caracteres" }
  validates :comprobar_fecha

  #Fecha de la creación del evento no puede ser menor que la del día actual
  def comprobar_fecha
    if datetime < Date.today
      #Añadimos error
      errors.add(:datetime, "Fecha incorrecta")
  end
end
