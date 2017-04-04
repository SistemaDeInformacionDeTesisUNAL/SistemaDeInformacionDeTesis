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
  
  #muestra todos los eventos de todos los profesores
  def self.allTeachersEvents

	Teacher.all.each do |teach|
		puts "Id: "+teach.id.to_s
		puts "Name: "+teach.name.to_s
		puts "Events: "+teach.event_ids.to_s
		puts "--------\n"
	end
  end
  
  #muestra todas las contribuciones de los profesores
  def self.allTeachersContributions

	Teacher.all.each do |teach|
		puts "Id: "+teach.id.to_s
		puts "Name: "+teach.name.to_s
		puts "contributions"+ teach.contribution_ids.to_s
		puts "--------\n"
	end
  end
  
	#muestra todos los grupos de investigacion por profesor
  def self.allTeachersGroups

	Teacher.all.each do |teach|
		puts "Id: "+teach.id.to_s
		puts "Name: "+teach.name.to_s
		puts "InvestigationGroup"+ teach.investigation_group_ids.to_s
		puts "--------\n"
	end
  end
  
  #muestra el id y nombre del evento corresponiente a un profesor
  def self.event_by_Teacher(teacher_id,page=1, per_page=3)
    Teacher.find_by_id(teacher_id).event_ids.each do |evento|
		puts "Id de Evento:" + evento.to_s
		puts "Nombre de Evento:" + Event.find_by_id(evento).name
	end
  end
  
	 #muestra el id y nombre de la contribucion corresponiente a un profesor
  def self.contribution_by_Teacher(teacher_id,page=1, per_page=3)
    Teacher.find_by_id(teacher_id).contribution_ids.each do |contrib|
		puts "Id Contribucion:" + contrib.to_s
		puts "Nombre contribucion:" + Contribution.find_by_id(contrib).name
	end
  end 
  
	 #muestra el id y nombre del grupo de investigacion corresponiente a un profesor
  def self.group_by_Teacher(teacher_id,page=1, per_page=3)
    Teacher.find_by_id(teacher_id).investigation_group_ids.each do |group|
		puts "Id de Grupo Investigacion:" + group.to_s
		puts "Nombre Grupo investigacion:" + InvestigationGroup.find_by_id(group).name
	end
  end
  
	#muestra el id y URL del perfil de un profesor
	def self.profile_by_Teacher(teacher_id,page=1, per_page=3)
    Teacher.find_by_id(teacher_id).profile_ids.each do |prof|
		puts "Id Profile:" + prof.to_s
		puts "URL profile:" + Profile.find_by_id(prof).URL
	end
  end
  
  #muestra el id y datos del history group de un profesor
	def self.history_by_Teacher(teacher_id,page=1, per_page=3)
    Teacher.find_by_id(teacher_id).history_group_ids.each do |hist|
		puts "Id History Group:" + hist.to_s
		puts "bonding date:" + HistoryGroup.find_by_id(hist).bonding_date.to_s
		puts "exit date:" + HistoryGroup.find_by_id(hist).exit_date.to_s
		puts "state:" + HistoryGroup.find_by_id(hist).state
		puts "Investigation Group:" + HistoryGroup.find_by_id(hist).investigation_group_id.to_s
	end
  end
  
  #busca relaciones de teacher
  def self.teacher_by_id(teacher_id)
	#includes(:events,:history_groups,:contributions,:investigation_groups,:profiles).find_by_id(teacher_id).paginate(:page => 1,:per_page =>10 )
	includes(:events,:history_groups,:contributions,:investigation_groups,:profiles).find_by_id(teacher_id)
 end
	
	#Devuelve el rol del profesor 
	def self.teacher_rol(teacher_id)
		Teacher.find_by_id(teacher_id).teacher_investigation_group_ids.each do |r|
			puts "Id teacher investigationGroup:" + r.to_s
			puts "teacher id:" + TeacherInvestigationGroup.find_by_id(r).teacher_id.to_s
			puts "teacher rol:" + TeacherInvestigationGroup.find_by_id(r).rol
		end
	end
 

 
end
