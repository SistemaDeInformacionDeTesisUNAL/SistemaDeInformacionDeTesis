class Teacher < ActiveRecord::Base

  has_many :profiles, as: :profileable, dependent: :destroy

  has_many :event_teachers
  has_many :events, through: :event_teachers

  has_many :user_contributions, as: :userable, dependent: :destroy
	has_many :contributions, through: :user_contributions

  has_many :history_groups, as: :historable, dependent: :destroy

  has_many :teacher_investigation_groups
	has_many :investigation_groups, through: :teacher_investigation_groups

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

#Carga todos los grupos de investigacion
  def self.load_investigation_groups(**args)
    includes(:investigation_groups).paginate(:page=>args[:page],:per_page=>args[:per_page])
  end
end
