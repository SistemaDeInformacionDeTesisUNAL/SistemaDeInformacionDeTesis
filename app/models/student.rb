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

 #No se ha probado
  #muestra el id y nombre del evento corresponiente a un estudiante
  def self.event_by_Student(student_id,page=1, per_page=3)
    Student.find_by_id(student_id).event_ids.each do |evento|
		puts "Id de Evento:" + evento.to_s
		puts "Nombre de Evento:" + Event.find_by_id(evento).name
		puts "descripcion:" + Event.find_by_id(evento).description
		puts "Fecha creacion de Evento:" + Event.find_by_id(evento).created_at.to_s
		puts "Fecha actualizacion de Evento:" + Event.find_by_id(evento).updated_at.to_s

	end
  end

	 #muestra el id y nombre de la contribucion corresponiente a un estudiante
  def self.contribution_by_Student(student_id,page=1, per_page=3)
    Student.find_by_id(student_id).contribution_ids.each do |contrib|
		puts "Id Contribucion:" + contrib.to_s
		puts "Nombre contribucion:" + Contribution.find_by_id(contrib).name
		puts "description:" + Contribution.find_by_id(contrib).description
		puts "state Contribucion:" + Contribution.find_by_id(contrib).state
		puts "Fecha creacion:" + Contribution.find_by_id(contrib).created_at.to_s
		puts "Fecha actualizacion:" + Contribution.find_by_id(contrib).updated_at.to_s
	end
  end

	 #muestra el id y nombre del grupo de investigacion corresponiente a un estudiante
  def self.group_by_Student(student_id,page=1, per_page=3)
    Student.find_by_id(student_id).investigation_group_id
	#puts "Id de Grupo Investigacion:" + group.to_s
	puts "Nombre Grupo investigacion:" + InvestigationGroup.find_by_id( Student.find_by_id(student_id).investigation_group_id).name
	puts "description:" + InvestigationGroup.find_by_id( Student.find_by_id(student_id).investigation_group_id).description

  end

	#muestra el id y URL del perfil de un estudiante
	def self.profile_by_Student(student_id,page=1, per_page=3)
    Student.find_by_id(student_id).profile_ids.each do |prof|
		puts "Id Profile:" + prof.to_s
		puts "URL profile:" + Profile.find_by_id(prof).URL
	end
  end

  #muestra el id y datos del history group de un estudiante dentro del grupo de investigacion
	def self.history_by_Student(student_id,page=1, per_page=3)
    Student.find_by_id(student_id).history_group_ids.each do |hist|
		puts "Id History Group:" + hist.to_s
		puts "bonding date:" + HistoryGroup.find_by_id(hist).bonding_date.to_s
		puts "exit date:" + HistoryGroup.find_by_id(hist).exit_date.to_s
		puts "state:" + HistoryGroup.find_by_id(hist).state
		puts "Investigation Group:" + HistoryGroup.find_by_id(hist).investigation_group_id.to_s
	end
  end


end
