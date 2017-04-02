class Teacher < ActiveRecord::Base
  default_scope {order("teachers.institutional_user ASC")}
  scope :order_by_institutional_user, -> (type) {order("teachers.institutional_user #{type}")}
  
  has_many :profiles

  has_many :event_teachers
  has_many :events, through: :event_teachers

  has_many :user_contributions
  has_many :contributions, through: :user_contributions

  has_many :teacher_investigation_groups
  has_many :investigation_groups, through: :teacher_investigation_groups

  has_many :history_groups
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  validates :name, :presence => true
  validates :lastname, :presence => true
  validates :institutional_user, :presence => true
  validates :name, :lastname, :length => { :maximum => 25, :too_long => "%{count} Demasiados caracteres" }
  validates :institutional_user, :uniqueness => true
  
   def self.load_teachers_page(page = 1, per_page = 10)
	 includes(:profiles,:teacher_investigation_groups,:user_contributions).paginate(:page => page,:per_page => per_page)
   end
   
   def self.load_teachers(**args)
     
	 #includes(:name,:lastname,:institutional_user).paginate(:page => args[:page],:per_page => args[:per_page])
	 includes(:name,:lastname,:institutional_user)
   end 
   
   def self.teacher_by_id(id)
	
	#includes(:name,:lastname,:institutional_user).find_by_id(:id)
	includes(:event_teachers).find_by_id(:id)
   end
  
  #by id numero 2 
#  def self.teacher_by_id(id)
	#includes(:profiles,:teacher_investigation_groups,:event_teachers,:user_contributions,history_groups).find_by_id(id)

 # end
   
   #def self.teachers_by_ids(ids,page = 1 ,per_page = 10)
	#load_teachers_page(page,per_page).where(teachers: {id: ids})
   #end
   
   def self.teachers_by_ids(ids,**args)
     
	 load_teachers(args).where(teachers: {id: ids})
   end

   #def self.users_by_investigation_groups(page = 1, per_page = 10)
   #  joins(:investigation_groups).select("teachers.*").group("teachers.id").paginate(:page => page,:per_page => per_page)
   #end
   
   def self.users_by_investigation_groups(group_id,**args)
	load_groups(args).where("Teachers.investigation_group_id LIKE ?", "#{group_id}%")
   end

   def self.users_by_investigation_groups(page = 1, per_page = 10)
	includes(:investigation_groups).select("teachers.*").group("teacher_id").paginate(:page => page,:per_page => per_page)
   end

   def self.teacher_by_institutional_user(institutional_user,**args)
   #def self.teacher_by_institutional_user(page = 1, per_page = 10)
	#includes(:investigation_groups).where("teachers.institutional_user LIKE ?", "#{institutional_user.downcase}%")
	load_teachers(args).where("teachers.institutional_user LIKE ?", "#{institutional_user.downcase}%")
   end
   

  
end
