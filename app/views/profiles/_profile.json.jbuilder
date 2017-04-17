json.extract! profile, :id, :entity, :URL, :profileable_type, :profileable_id, :created_at, :updated_at
json.url profile_url(profile, format: :json)
