class InvestigationGroup < ApplicationRecord
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
  validates :name, :length => { :maximum => 100, :too_long => "%{count} Demasiados caracteres" }
  validates :name, :length => { :minimum => 5, :too_short => "%{count} Muy pocos caracteres" }
  validates :description, :length => { :maximum => 200, :too_long => "%{count} Demasiados caracteres" }

 mount_uploader :image, ImageUploader

#busca grupos de investigacion por eventos
  def self.load_groups(**args)
	   includes(:events).paginate(:page => args[:page],:per_page => args[:per_page])
  end
#busca grupos de investigacion por tags
  def self.load_investigation_groups_tags(**args)
    includes(:tags).paginate(:page => args[:page],:per_page => args[:per_page])
  end
#busca grupo de investigacion por un tag en especifico
  def self.investigation_group_by_tag_name(**args)
    if !args[:tag].blank? then
        load_investigation_groups_tags.where( tags: { id: args[:tag]} ).paginate(:page => args[:page],:per_page => args[:per_page])
      else
        load_groups(:page => args[:page],:per_page => args[:per_page])
    end
  end

  #Cuenta cuantos grupos de investigacion hay en total, necesaria para hacer el indice para separar por paginas
  def self.countGroups
    InvestigationGroup.all.count
  end

  #Busca las contribuciones de un grupo de investigacion
  def self.contributions_group(**args)
    Contribution.load_contributions.where( investigation_groups: {id: args[:group_id]})
  end

  def self.load_groups(**args)
	   includes(:events).paginate(:page => args[:page],:per_page => args[:per_page])
  end

  #Buscar el profesor owner del grupo buscando por id del grupo (usar ids page y per_page)
  def self.teacher_group_owner(**args)

      list =[]
      s2="owner"
      rolt=TeacherInvestigationGroup.load_group_teachers.where(investigation_groups:{id: args[:id]})
      rolt.each do |r|
          if r.rol.downcase ==s2
              list.push(r.teacher_id)
          end
      end
      a=list.pop
      #return list
      c=TeacherInvestigationGroup.find(a)
      #puts c
      d= c.id
      #puts d
      Teacher.find(d)

  end

#listar los profesores del grupo de investigacion (usar ids page y per_page)
def self.teachers_group(**args)
  rolt=TeacherInvestigationGroup.load_group_teachers.where(investigation_groups:{id: args[:ids]})
end

#listar los estudiantes del grupo de investigacion (usar ids page y per_page)
def self.students_group(**args)
  Student.load_students.where(investigation_groups:{id: args[:ids]})
end

end
