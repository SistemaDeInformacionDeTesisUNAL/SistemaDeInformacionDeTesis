json.extract! user_contribution, :id, :userable_type, :userable_id, :contribution_id, :created_at, :updated_at
json.url user_contribution_url(user_contribution, format: :json)
