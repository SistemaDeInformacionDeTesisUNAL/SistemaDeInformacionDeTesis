json.extract! user_contribution, :id, :student_id, :teacher_id, :contribution_id, :created_at, :updated_at
json.url user_contribution_url(user_contribution, format: :json)
