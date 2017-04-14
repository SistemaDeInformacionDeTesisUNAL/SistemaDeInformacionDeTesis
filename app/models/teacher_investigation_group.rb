class TeacherInvestigationGroup < ApplicationRecord

  belongs_to :teacher
  belongs_to :investigation_group

  enum rol: {Teacher: 0, Admin: 1, Owner: 2}

  validates :rol, inclusion: { in: rols.keys }

  def self.load_group_teachers(**args)
    includes(:investigation_group).paginate(:page=>args[:page],:per_page=>args[:per_page])
  end

end
