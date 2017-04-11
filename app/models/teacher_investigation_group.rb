class TeacherInvestigationGroup < ApplicationRecord

  belongs_to :teacher
  belongs_to :investigation_group

  enum rol: {Teacher: 0, Admin: 1, Owner: 2}

  validates :rol, inclusion: { in: rols.keys }

end
