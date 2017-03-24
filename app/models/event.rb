class Event < ApplicationRecord
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
end
