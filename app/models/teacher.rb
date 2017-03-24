class Teacher < ActiveRecord::Base
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
end
