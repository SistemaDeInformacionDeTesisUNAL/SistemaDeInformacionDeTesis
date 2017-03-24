json.extract! event, :id, :name, :date, :time, :description, :investigation_group_id, :created_at, :updated_at
json.url event_url(event, format: :json)
