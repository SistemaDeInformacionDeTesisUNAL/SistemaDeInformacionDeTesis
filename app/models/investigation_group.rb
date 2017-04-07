class InvestigationGroup < ApplicationRecord
#<<<<<<< HEAD
	#attr_accessor :name, :create_date, :description
#=======

#>>>>>>> 793ab9efb00af13e2b7d3a6d0b8228970e5a42a3
  has_many :students

	has_many :teacher_investigation_groups
	has_many :teachers, through: :teacher_investigation_groups

	has_many :contributions

	has_many :tag_investigation_groups
	has_many :tags, through: :tag_investigation_groups

	has_many :events

	has_many :history_groups

  default_scope {order("investigation_groups.name ASC")}
  scope :sort_by_name, -> (ord) {order("investigation_groups.name #{ord}")}
  scope :sort_by_create_date, -> (ord) {order("investigation_groups.created_at #{ord}")}

  validates :name, :create_date, :presence => true
  #validates :name, :presence => true
  validates :name, :length => { :maximum => 100, :too_long => "%{count} Demasiados caracteres" }
  validates :name, :length => { :minimum => 5, :too_short => "%{count} Muy pocos caracteres" }
  validates :description, :length => { :maximum => 200, :too_long => "%{count} Demasiados caracteres" }
  #validates :comprobar_fecha

  #Fecha de la creación del grupo de investigación no puede ser mayor que la del día actual
  def comprobar_fecha
    if :create_date > Date.today
      #Añadimos error
      errors.add(:create_date, "Fecha incorrecta")
    end
  end


  #no funciona al llamar el metodo pero si al poner una por una las lineas en la consola
  #imprime los eventos correspondientes a un grupo de investigacion usando includes
  #def allEvents(groupId)
	#grupos=InvestigationGroup.includes(:events)
	#idsEventos=grupos.find_by_id(groupId).event_ids
	#idsEventos.each do |idEvento|
	#	puts "Nombre evento: " + Event.find(idEvento).name
	#end
  #end

  #sirve tambien
  #def self.load_groups(**args)
  #includes(:name,:create_date,:description).paginate(:page => args[:page],:per_page => args[:per_page])
  #end


  def self.countGroup
    InvestigationGroup.all.count
  end
  #lista las contribuciones
  def self.load_groups(id)
	   includes(:events,:tags,:contributions,:students,:teachers).paginate(:page => page,:per_page => per_page)
  end


  #muestra relaciones de eventos, tags, contribuciones de un grupo pero no als muestra
  def self.group_by_id(group_id)
	includes(:events,:tag_investigation_groups,:contributions).find_by_id(group_id).paginate(:page => 1,:per_page =>10 )
 end

 #error
#  def self.groups_by_ids(ids,**args)
 #   load_groups(args).where(investigation_groups: {id: ids})
 # end


#muestra el id y nombre del evento corresponiente a un grupo de investigación
  def self.event_by_investigationGroup(group_id,page=1, per_page=3)
    InvestigationGroup.find_by_id(group_id).event_ids.each do |evento|
		puts "Id de Evento:" + evento.to_s
		puts "Nombre de Evento:" + Event.find_by_id(evento).name
	end
end



#	def self.event_by_ig(group_id)
#		Elementos = InvestigationGroup.includes(:events,:tag_investigation_groups,:contributions).where(investigation_groups:{id: group_id})
#		Elementos.each do |elemento|
#			elemento.events do |event|
#				puts "Id evento: "+event.id.to_s
#			end
#			elemento.tag_investigation_groups do |tag|
#				puts "Id Tag: "+tag.id.to_s
#			end
#			elemento.contributions do |contribution|
#				puts "Id Contribucion: "+contribution.id.to_s
#			end
#			puts "--------\n"
#		end
#	end

  #metodo para mostrar todos los grupos en consola y un arreglo de ids de sus eventos
  def self.allGroupsConsole

	InvestigationGroup.all.each do |group|
		puts "Id: "+group.id.to_s
		puts "Nombre: "+group.name.to_s
		puts "Eventos: "+group.event_ids.to_s
		puts "--------\n"
	end
  end

    #Devuelve las contribuciones de un grupo de investigacion, nombre estado y descripcion
  def self.contribution_by_group(group_id,page=1, per_page=3)
    InvestigationGroup.find_by_id(group_id).contribution_ids.each do |t|
		puts "Id contribution:" + t.to_s
		#puts "Id contribution:" + Contribution.find_by_id(t).id.to_s
		puts "name contribution:" + Contribution.find_by_id(t).name
		puts "description:" + Contribution.find_by_id(t).description
		puts "state contribution:" + Contribution.find_by_id(t).state

	end
  end

    #Devuelve los tags de un grupo de investigacion
  def self.tag_by_group(group_id,page=1, per_page=3)
    InvestigationGroup.find_by_id(group_id).tag_ids.each do |t|
		puts "Id tag:" + t.to_s
		#puts "Tag id:" + Tag.find_by_id(t).id.to_s
		puts "Tag name:" + Tag.find_by_id(t).name
		puts "description:" + Tag.find_by_id(t).description

	end
  end
  #Muestra el historial de un grupo de investigacion
  def self.history_by_group(group_id,page=1, per_page=3)
    InvestigationGroup.find_by_id(group_id).history_group_ids.each do |hist|
		puts "Id History Group:" + hist.to_s
		puts "Type user:" + HistoryGroup.find_by_id(hist).historable_type
		puts "Id user:" + HistoryGroup.find_by_id(hist).historable_id.to_s
		puts "bonding date:" + HistoryGroup.find_by_id(hist).bonding_date.to_s
		puts "exit date:" + HistoryGroup.find_by_id(hist).exit_date.to_s
		puts "state:" + HistoryGroup.find_by_id(hist).state
		puts "Investigation Group:" + HistoryGroup.find_by_id(hist).investigation_group_id.to_s

	end
  end
  #estudiantes grupo de investigacion
  def self.students_by_group(group_id,page=1, per_page=3)
    InvestigationGroup.find_by_id(group_id).student_ids.each do |c|
		puts "Id student:" + c.to_s
		#puts "Id user:" + UserContribution.find_by_id(c).userable_id.to_s
		puts "Name user:" + Student.find_by_id(c).name
		puts "Email user:" + Student.find_by_id(c).institutional_user

	end
  end

#profesores grupo de investigacion
 def self.teachers_by_group(group_id,page=1, per_page=3)
    InvestigationGroup.find_by_id(group_id).teacher_ids.each do |c|
		puts "Id teacher:" + c.to_s
		#puts "Id user:" + UserContribution.find_by_id(c).userable_id.to_s
		puts "Name Teacher:" + Teacher.find_by_id(c).name
		puts "Lastname Teacher:" + Teacher.find_by_id(c).lastname
		puts "Email Teacher:" + Teacher.find_by_id(c).institutional_user
		puts "Rol Teacher:" + TeacherInvestigationGroup.find_by_id(Teacher.find_by_id(c)).rol

	end
  end

end
