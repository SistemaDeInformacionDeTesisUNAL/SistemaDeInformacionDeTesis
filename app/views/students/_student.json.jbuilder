json.extract! student, :id, :first_name, :last_name, :username, :email, :investigation_group_id, :created_at, :updated_at
json.url student_url(student, format: :json)
