class Contribution < ActiveRecord::Base

  has_many :user_contributions
  has_many :students, through: :user_contributions
	has_many :teachers, through: :user_contributions

  belongs_to :investigation_group

  has_many :ubications

  has_many :tag_contributions
  has_many :tags, through: :tag_contributions

  enum status: [ :Aproved, :Rejected, :Progress ]

  validates :name, :publication_date, :presence => true
  validates :state, :presence => true
  validates :name, :length => { :maximum => 100, :too_long => "%{count} Demasiados caracteres" }
  validates :name, :length => { :minimum => 5, :too_short => "%{count} Muy pocos caracteres" }
  validates :description, :length => { :maximum => 200, :too_long => "%{count} Demasiados caracteres" }
  validates_inclusion_of :state, in: 0..2
  #validates :comprobar_fecha

  #Fecha de la contribución no puede ser mayor que la del día actual
  def comprobar_fecha
    if :publication_date > Date.today
      #Añadimos error
      errors.add(:publication_date, "Fecha incorrecta")
    end
  end
end
