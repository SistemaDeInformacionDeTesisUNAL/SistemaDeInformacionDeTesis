class Student < ApplicationRecord

  belongs_to :investigation_group

  has_many :event_students
  has_many :events, through: :event_students

  has_many :user_contributions, as: :userable, dependent: :destroy
  has_many :contributions, through: :user_contributions

  has_many :history_groups, as: :historable, dependent: :destroy

  enum state: {Rejected: 0, Process: 1, Admitted: 2}

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :ldap_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:username]

  validates :state, inclusion: { in: states.keys }
  validates :username, presence: true, uniqueness: true
  mount_uploader :image, ImageUploader

  def ldap_before_save
     self.email = Devise::LDAP::Adapter.get_ldap_param(self.username,"mail").first
     self.first_name = Devise::LDAP::Adapter.get_ldap_param(self.username,"givenname").first
     self.last_name = Devise::LDAP::Adapter.get_ldap_param(self.username,"sn").first
     self.investigation_group_id = 1
     self.state = 0
     #demas campos del modelo
     #self.autorize = false
  end

  #Carga todos los estudiantes en grupos de investigacion
  def self.load_students(**args)
    includes(:investigation_group)
  end

  #Carga todas las contribuciones hechas por estuadiantes
  def self.load_contributions(**args)
    includes(:contributions)
  end

  #Contribuciones del estudiante
  def self.students_by_contribution(**args)
    load_contributions.where( contributions: { id: args[:ids] } )
  end

  #Carga todos los grupos de investigacion
  def self.load_investigation_group(**args)
    includes(:investigation_group)
  end
end
