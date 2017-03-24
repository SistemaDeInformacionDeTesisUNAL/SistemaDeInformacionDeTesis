class Tag < ApplicationRecord
	has_many :tag_contributions
	has_many :contributions, through: :tag_contributions

	has_many :tag_investigation_groups
	has_many :investigation_groups, through: :tag_investigation_groups
end
