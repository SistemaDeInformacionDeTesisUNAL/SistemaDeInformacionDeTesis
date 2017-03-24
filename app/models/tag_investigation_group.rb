class TagInvestigationGroup < ApplicationRecord
  belongs_to :tag
  belongs_to :investigation_group
end
