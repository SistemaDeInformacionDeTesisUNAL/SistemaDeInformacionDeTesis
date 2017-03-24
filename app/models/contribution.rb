class Contribution < ApplicationRecord
  has_many :user_contributions
  has_many :students, through: :user_contributions
	has_many :teachers, through: :user_contributions

  belongs_to :investigation_group

  has_many :ubications

  has_many :tag_contributions
  has_many :tags, through: :tag_contributions

  enum state: [:Aproved, :Rejected, :Progress]
end
