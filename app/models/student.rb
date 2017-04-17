class Student < ActiveRecord::Base

  belongs_to :investigation_group

  has_many :profiles, as: :profileable, dependent: :destroy

  has_many :event_students
  has_many :events, through: :event_students

  has_many :user_contributions, as: :userable, dependent: :destroy
  has_many :contributions, through: :user_contributions

  has_many :history_groups, as: :historable, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :ldap_authenticatable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:username]
  validates :username,:presence => true,:uniqueness => {
    :case_sensitive => false
  }

  def ldap_before_save
     self.email = Devise::LDAP::Adapter.get_ldap_param(self.username,"mail").first
     self.name = Devise::LDAP::Adapter.get_ldap_param(self.username,"givenname").first
     self.lastname = Devise::LDAP::Adapter.get_ldap_param(self.username,"sn").first
  end

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
