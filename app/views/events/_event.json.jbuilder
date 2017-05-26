json.extract! event, :id, :description, :investigation_group_id, :created_at, :updated_at
json.title event.name
json.start event.start_time
json.end event.end_time
json.url event_url(event, format: :html)
