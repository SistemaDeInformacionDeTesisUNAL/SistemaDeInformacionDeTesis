class TagInvestigationGroup < ApplicationRecord
  belongs_to :tag
  belongs_to :investigationGroup
end
