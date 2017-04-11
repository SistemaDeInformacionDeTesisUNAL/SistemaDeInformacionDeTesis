class Student < ActiveRecord::Base
  belongs_to :investigation_group

  has_many :profiles, as: :profileable, dependent: :destroy

  has_many :event_students
  has_many :events, through: :event_students

  has_many :user_contributions, as: :userable, dependent: :destroy
  has_many :contributions, through: :user_contributions

  has_many :history_groups, as: :historable, dependent: :destroy

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  validates :name, :lastname, :institutional_user, :presence => true
  validates :name, :lastname, :length => { :maximum => 25, :too_long => "%{count} Demasiados caracteres" }
  validates :institutional_user, :uniqueness => true

  #Carga todos los estudiantes en grupos de investigacion
  def self.load_students(**args)
    includes(:investigation_group).paginate(:page => args[:page],:per_page => args[:per_page])
  end

  #Carga todas las contribuciones hechas por estuadiantes
  def self.load_contributions(**args)
    includes(:contributions).paginate(:page => args[:page],:per_page => args[:per_page])
  end

  #Contribuciones del estudiante
  def self.students_by_contribution(**args)
    load_contributions.where( contributions: { id: args[:ids] } )
  end

  #Perfiles del estudiante
  def self.students_profiles(**args)
    Profile.load_profiles.where( profiles: { profileable_type: "Student", profileable_id: args[:ids] } )
  end

end
