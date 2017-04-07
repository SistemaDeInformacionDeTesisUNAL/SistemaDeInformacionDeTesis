class Contribution < ActiveRecord::Base

  has_many :user_contributions
  has_many :students, through: :user_contributions
  has_many :teachers, through: :user_contributions

  belongs_to :investigation_group

  has_many :ubications

  has_many :tag_contributions
  has_many :tags, through: :tag_contributions

  enum state: {Aproved: 0, Rejected: 1, Progress: 2}

  validates :name, :publication_date, :presence => true
  validates :name, :length => { :maximum => 100, :too_long => "%{count} Demasiados caracteres" }
  validates :name, :length => { :minimum => 5, :too_short => "%{count} Muy pocos caracteres" }
  validates :description, :length => { :maximum => 200, :too_long => "%{count} Demasiados caracteres" }
  validates :state, inclusion: { in: states.keys }
  #validates :comprobar_fecha

  #Fecha de la contribución no puede ser mayor que la del día actual
  def comprobar_fecha
    if :publication_date > Date.today
      #Añadimos error
      errors.add(:publication_date, "Fecha incorrecta")
    end
  end
#Cuenta cuantas contribuciones hay en total
  def self.count
    Contribution.all.count
  end
  #lista las contribuciones
  def self.load_contributions(**args)    
    includes(:investigation_group).paginate(:page => args[:page],:per_page => args[:per_page])
  end
  #Muestra la ubicacion dada una contribucion
	def self.ubication_by_contribution(contribution_id)
		Contribution.find_by_id(contribution_id).ubication_ids.each do |u|
			puts "Id ubication contribution:" + u.to_s
			puts "Id contribution:" + Ubication.find_by_id(u).contribution_id.to_s
			puts "link" + Ubication.find_by_id(u).link
		end
	end

  #Devuelve el usuario dueño dada una contribucion
  def self.user_by_contribution(contribution_id,page=1, per_page=3)
    Contribution.find_by_id(contribution_id).user_contribution_ids.each do |c|
		puts "Id user contribution:" + c.to_s
		#puts "Id user:" + UserContribution.find_by_id(c).userable_id.to_s
		puts "Name user:" + UserContribution.find_by_id(c).userable_type

	end
  end

  #Devuelve los tags de una contribucion
  def self.tags_by_contribution(contribution_id,page=1, per_page=3)
    Contribution.find_by_id(contribution_id).tag_ids.each do |t|
		puts "Id tag:" + t.to_s
		puts "Tag name:" + Tag.find_by_id(t).name
		puts "description:" + Tag.find_by_id(t).description

	end
  end

	 def self.contribution_by_id(contribution_id)

	includes(:investigation_group).find_by_id(contribution_id)
  end


end
