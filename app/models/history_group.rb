class HistoryGroup < ApplicationRecord
  belongs_to :investigation_group
  belongs_to :student
  belongs_to :teacher
end
