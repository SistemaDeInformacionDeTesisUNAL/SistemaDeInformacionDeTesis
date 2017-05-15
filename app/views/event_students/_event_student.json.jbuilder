json.extract! event_student, :id, :description, :investigation_group_id, :created_at, :updated_at
json.title event_student.name
json.start event_student.start_time
json.end event_student.end_time
json.url event_url(event, format: :html)
