class Teacher < ActiveRecord::Base
  has_many :profiles, as: :profileable, dependent: :destroy

  has_many :event_teachers
  has_many :events, through: :event_teachers

  has_many :user_contributions, as: :userable, dependent: :destroy
	has_many :contributions, through: :user_contributions

  has_many :teacher_investigation_groups
	has_many :investigation_groups, through: :teacher_investigation_groups

  has_many :history_groups, as: :historable, dependent: :destroy
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  validates :name, :lastname, :institutional_user, :presence => true
  validates :name, :lastname, :length => { :maximum => 25, :too_long => "%{count} Demasiados caracteres" }
  validates :institutional_user, :uniqueness => true

  #Carga todas las contribuciones
  def self.load_contributions(**args)
    includes(:contributions).paginate(:page => args[:page],:per_page => args[:per_page])
  end

  #Contribuciones del profesor
  def self.teachers_by_contribution(**args)
    load_contributions.where( contributions: { id: args[:ids] } )
  end

  #Perfiles del profesor
  def self.teachers_profiles(**args)
    Profile.load_profiles.where( profiles: { profileable_type: "Teacher", profileable_id: args[:ids] } )
  end

end
