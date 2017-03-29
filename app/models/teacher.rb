class Teacher < ActiveRecord::Base
  attr_accessible :name, :lastname, :institutional_user, :rol
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
end
