class EventStudent < ApplicationRecord
  belongs_to :event
  belongs_to :student
  #self.primary_keys :event_id, :institutional_user
end
