class TeacherInvestigationGroup < ApplicationRecord
  belongs_to :teacher
  belongs_to :investigation_group

  enum rol: {Admin: 0, Owner: 1, Teacher: 2}

  validates :rol, :presence => true
  validates_inclusion_of :rol, in: 0..2
end
