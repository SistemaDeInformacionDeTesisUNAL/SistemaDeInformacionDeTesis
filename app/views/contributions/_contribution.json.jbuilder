json.extract! contribution, :id, :name, :publication_date, :description, :investigation_group_id, :created_at, :updated_at
json.url contribution_url(contribution, format: :json)
