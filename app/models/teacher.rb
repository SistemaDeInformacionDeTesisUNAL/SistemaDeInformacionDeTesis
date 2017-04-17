class Teacher < ApplicationRecord

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
  devise :ldap_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, uniqueness: true

  before_validation :get_ldap_email
  def get_ldap_email
    self.email = Devise::LDAP::Adapter.get_ldap_param(self.username,"mail").first
  end

  # use ldap uid as primary key
  before_validation :get_ldap_id
  def get_ldap_id
    self.id = Devise::LDAP::Adapter.get_ldap_param(self.username,"uidnumber").first
  end

  # hack for remember_token
  def authenticatable_token
    Digest::SHA1.hexdigest(email)[0,29]
  end
end
