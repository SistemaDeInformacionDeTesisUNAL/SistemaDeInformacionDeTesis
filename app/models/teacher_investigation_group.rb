class TeacherInvestigationGroup < ApplicationRecord
  belongs_to :teacher
  belongs_to :investigation_group

  enum rol: {Admin: 0, Owner: 1, Teacher: 2}

  validates :rol, :presence => true
  validates :rol, :numericality { :only_integer => true }
  validates :rol, :numericality { :greater_than_or_equal_to => 0 }
  validates :rol, :numericality { :less_than_or_equal_to => 2 }
end
