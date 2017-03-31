class Contribution < ApplicationRecord
  attr_accessor :name, :publication_date, :state, :description
  
  default_scope {order("contributions.publication_date ASC")}
  scope :order_by_publication_date, -> (type) {order("contributions.publication_date #{type}")}

  has_many :user_contributions
  has_many :students, through: :user_contributions
  has_many :teachers, through: :user_contributions

  belongs_to :investigation_group

  has_many :ubications

  has_many :tag_contributions
  has_many :tags, through: :tag_contributions

  enum state: {Aproved: 0, Rejected: 1, Progress: 2}

  validates :name, :publication_date, :state, :presence => true
  validates :name, :length => { :maximum => 100, :too_long => "%{count} Demasiados caracteres" }
  validates :name, :length => { :minimum => 5, :too_short => "%{count} Muy pocos caracteres" }
  validates :description, :length => { :maximum => 200, :too_long => "%{count} Demasiados caracteres" }
  validates :state, :numericality { :only_integer => true }
  validates :state, :numericality { :greater_than_or_equal_to => 0 }
  validates :state, :numericality { :less_than_or_equal_to => 2 }
  validates :comprobar_fecha

  #Fecha de la contribución no puede ser mayor que la del día actual
  def comprobar_fecha
    if publication_date > Date.today
      #Añadimos error
      errors.add(:publication_date, "Fecha incorrecta")
  end
  
  def self.load_contributions(page = 1, per_page = 10)
     includes(:tag_contributions,:investigation_group,:ubications,:user_contributions).paginate(:page => page,:per_page => per_page)
   end 
   
   def self.contribution_by_id(id)
	includes(:ubications,:investigation_group,:user_contributions,:tag_contributions).find_by_id(id)
   end
  
end
