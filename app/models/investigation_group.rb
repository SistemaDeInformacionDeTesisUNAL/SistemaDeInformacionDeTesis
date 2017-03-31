class InvestigationGroup < ApplicationRecord
	attr_accessor :name, :create_date, :description
  has_many :students

	has_many :teacher_investigation_groups
	has_many :teachers, through: :teacher_investigation_groups

	has_many :contributions

	has_many :tag_investigation_groups
	has_many :tags, through: :tag_investigation_groups

	has_many :events

	has_many :history_groups

  validates :name, :create_date, :presence => true
  validates :name, :length => { :maximum => 100, :too_long => "%{count} Demasiados caracteres" }
  validates :name, :length => { :minimum => 5, :too_short => "%{count} Muy pocos caracteres" }
  validates :description, :length => { :maximum => 200, :too_long => "%{count} Demasiados caracteres" }
  validates :comprobar_fecha

  #Fecha de la creación del grupo de investigación no puede ser mayor que la del día actual
  def comprobar_fecha
    if create_date > Date.today
      #Añadimos error
      errors.add(:create_date, "Fecha incorrecta")
  end
end
