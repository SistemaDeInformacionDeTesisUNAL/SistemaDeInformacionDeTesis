class UserContribution < ApplicationRecord
  belongs_to :student
  belongs_to :teacher
  belongs_to :contribution
end
