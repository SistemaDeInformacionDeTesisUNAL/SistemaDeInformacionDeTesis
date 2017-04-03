class TeacherInvestigationGroup < ApplicationRecord

  belongs_to :teacher
  belongs_to :investigation_group

  enum rol: [ :Teacher, :Admin, :Owner ]

  validates :rol, :presence => true
	validates_inclusion_of :rol, in: 0..2
end
