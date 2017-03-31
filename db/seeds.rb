# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
aleatorio=Random.new
for i in (1..100)

	Event.new( name: random_string(10), date: nil, time: nil, description: random_string(40), investigation_group_id: aleatorio.rand(100),created_at: DateTime.new, updated_at: DateTime.new)

	HistoryGroup.new( bonding_date: DateTime.new, exit_date: DateTime.new, investigation_group_id: nil,student_id: nil,teacher_id: nil,state: nil, created_at: DateTime.new, updated_at: DateTime.new)

	InvestigationGroup.new( name: random_string(10), createDate: DateTime.new, description: random_string(30), created_at: DateTime.new, updated_at: DateTime.new)

	Profile.new( entity: nil, URL: nil, student_id: aleatorio.rand(100),teacher_id: aleatorio.rand(100),created_at: DateTime.new, updated_at: DateTime.new)

	Student.new( provider: "institutional_user", uid: "", name: random_string(10), lastname: random_string(10), institutional_user: random_string(10), investigation_group_id: aleatorio.rand(100),created_at: DateTime.new, updated_at: DateTime.new)

	Tag.new(  name: random_string(10), description: random_string(30), created_at: DateTime.new, updated_at: DateTime.new)

	TagContribution.new( tag_id: aleatorio.rand(100),contribution_id: aleatorio.rand(100),created_at: DateTime.new, updated_at: DateTime.new)

	TagInvestigationGroup.new( tag_id: aleatorio.rand(100),investigation_group_id: aleatorio.rand(100),created_at: DateTime.new, updated_at: DateTime.new)

	Teacher.new( provider: "institutional_user", uid: "", unconfirmed_institutional_user: nil, name: random_string(10), lastname: random_string(10), institutional_user: random_string(10), created_at: DateTime.new, updated_at: DateTime.new)

	TeacherInvestigationGroup.new( teacher_id: aleatorio.rand(100),investigation_group_id: aleatorio.rand(100),rol: aleatorio.rand(3), created_at: DateTime.new, updated_at: DateTime.new)

	Teacher.new( provider: "institutional_user", uid: "", unconfirmed_institutional_user: nil, name: random_string(10), lastname: random_string(10), institutional_user: random_string(10), created_at: DateTime.new, updated_at: DateTime.new)

	Ubication.new( link: nil, contribution_id: aleatorio.rand(100),created_at: DateTime.new, updated_at: DateTime.new)

	UserContribution.new( student_id: aleatorio.rand(100),teacher_id: aleatorio.rand(100),contribution_id: aleatorio.rand(100),created_at: DateTime.new, updated_at: DateTime.new)

	Contribution.new( name: random_string(10), publication_date: DateTime.new, description: random_string(30), investigation_group_id: aleatorio.rand(100),state: aleatorio.rand(3), created_at: DateTime.new, updated_at: DateTime.new)

	EventStudent.new( event_id: aleatorio.rand(100),student_id: aleatorio.rand(100),created_at: DateTime.new, updated_at: DateTime.new)

	EventTeacher.new( event_id: aleatorio.rand(100),teacher_id: aleatorio.rand(100),created_at: DateTime.new, updated_at: DateTime.new)

end



