class EventStudent < ApplicationRecord
  belongs_to :event
  belongs_to :student
end
