json.extract! teacher, :id, :first_name, :last_name, :username, :email, :created_at, :updated_at
json.url teacher_url(teacher, format: :json)
