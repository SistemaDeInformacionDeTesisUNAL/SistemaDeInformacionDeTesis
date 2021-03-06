class InvestigationGroup < ApplicationRecord
  has_many :students

	has_many :teacher_investigation_groups
	has_many :teachers, through: :teacher_investigation_groups

	has_many :contributions

	has_many :tag_investigation_groups
	has_many :tags, through: :tag_investigation_groups

	has_many :events

	has_many :history_groups

  validates :name, :create_date, :presence => true
  validates :name, :length => { :maximum => 100, :too_long => "%{count} Demasiados caracteres" }
  validates :name, :length => { :minimum => 5, :too_short => "%{count} Muy pocos caracteres" }
  validates :description, :length => { :maximum => 200, :too_long => "%{count} Demasiados caracteres" }

  mount_uploader :image, ImageUploader

  #busca grupos de investigacion por eventos
  def self.load_groups(**args)
	   includes(:events,:tags)
  end
  #busca grupos de investigacion por tags
  def self.load_investigation_groups_tags(**args)
    includes(:tags)
  end

  #Cuenta cuantos grupos de investigacion hay en total, necesaria para hacer el indice para separar por paginas
  def self.countGroups
    InvestigationGroup.all.count
  end

  #Busca las contribuciones de un grupo de investigacion
  def self.contributions_group(**args)
    Contribution.load_contributions.where( investigation_groups: {id: args[:group_id]})
  end

  def self.events_group(**args)
    Event.load_events.where( investigation_groups: {id: args[:group_id]})
  end

  def self.load_groups(**args)
	   includes(:events)
  end

  #Buscar el profesor owner del grupo buscando por id del grupo (usar ids page y per_page)
  def self.teacher_group_owner(**args)
    list =[]
    rolt=TeacherInvestigationGroup.load_group_teachers.where(investigation_groups:{id: args[:id]})
    rolt.each do |r|
      if r.rol == 'Owner'
        list.push(r.teacher_id)
      end
    end
    a=list.pop
    c=TeacherInvestigationGroup.find(a)
    d= c.id
    Teacher.find(d)
  end

  def self.relationTeacherInvestigationGroup(**args)
    lista = TeacherInvestigationGroup.load_investigation_groups.where( teacher_id: args[:teacher_id], investigation_group_id: args[:investigation_group_id])
    lista.each do |r|
      return r
    end
  end

  #listar los profesores del grupo de investigacion (usar ids page y per_page)
  def self.teachers_group(**args)
    Teacher.load_investigation_groups.where(investigation_groups:{id: args[:id]})
  end

  def self.admins_group(**args)
    admins = []
    rolt=TeacherInvestigationGroup.load_group_teachers.where(investigation_groups:{id: args[:id]})
    rolt.each do |r|
      if r.rol == 'Admin'
        d = r.teacher_id
        admins.push(Teacher.find(d))
      end
    end
    return admins
  end

  def self.students_group(**args)
    Student.load_investigation_group.where(investigation_group_id: args[:id])
  end

end
