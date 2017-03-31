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

  validates :name, :lastname, :institutional_user, :presence => true
  validates :name, :lastname, :length => { :maximum => 25, :too_long => "%{count} Demasiados caracteres" }
  validates :institutional_user, :uniqueness => true
  
   def self.load_teachers(page = 1, per_page = 10)
     includes(:profiles,:teacher_investigation_groups,:user_contributions).paginate(:page => page,:per_page => per_page)
   end 
   
   def self.teacher_by_id(id)
	includes(:profiles,:teacher_investigation_groups,:event_teachers,:user_contributions,history_groups).find_by_id(id)
   end
   
   def self.teachers_by_ids(ids,page = 1 ,per_page = 10)
     load_teachers(page,per_page).where(teachers: {id: ids})
   end

   def self.users_by_investigation_groups(page = 1, per_page = 10)
     joins(:investigation_groups).select("teachers.*").group("teachers.id").paginate(:page => page,:per_page => per_page)
   end
   

  
end
