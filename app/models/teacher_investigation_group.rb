class TeacherInvestigationGroup < ApplicationRecord
  belongs_to :teacher
  belongs_to :investigation_group

  enum rol: {Teacher: 1, Admin: 2, Owner: 3}

  validates :rol, :presence => true
  validates_inclusion_of :rol, in: 1..3
end
