class TeacherInvestigationGroup < ApplicationRecord

  belongs_to :teacher
  belongs_to :investigation_group

  enum rol: {Teacher: 0, Admin: 1, Owner: 2}
  enum state: {Rejected: 0, Process: 1, Admitted: 2}

  validates :rol, inclusion: { in: rols.keys }
  validates :state, inclusion: { in: states.keys }

  def self.load_group_teachers(**args)
    includes(:investigation_group)
  end
  #Carga todos los grupos de investigacion
  def self.load_investigation_groups(**args)
    includes(:teacher,:investigation_group)
  end
  def self.load_group_owner(**args)
    load_investigation_groups.where( teachers: { id: args[:ids] }, rol: "Owner" )
  end
  def self.load_group_not_owner(**args)
    g = load_investigation_groups.where( teachers: { id: args[:ids] } )
    g.where.not( rol: "Owner" )
  end
  def self.load_groups_belong(**args)
    load_investigation_groups.where( teachers: { id: args[:ids] } )
  end
  def self.load_teachers(**args)
    load_investigation_groups.where( investigation_groups:{ id: args[:ids] } )
  end
end
