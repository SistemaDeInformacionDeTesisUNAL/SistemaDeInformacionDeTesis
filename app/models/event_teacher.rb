class EventTeacher < ApplicationRecord
  belongs_to :event
  belongs_to :teacher
end
