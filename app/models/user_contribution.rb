class UserContribution < ApplicationRecord
  belongs_to :userable, polymorphic: true
  belongs_to :contribution
end
