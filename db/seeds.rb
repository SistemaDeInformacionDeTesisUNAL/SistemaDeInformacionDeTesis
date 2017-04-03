# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
aleatorio = Random.new

def random_string(length=10)
	chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789'
	password = ''
	length.times { password << chars[rand(chars.size)] }
	return password
end

Teacher.create!( id: 0, provider: "unal.edu.co", uid: 0, name: "nada", lastname: "vacio", institutional_user: "nohay", password: "contrasenia", password_confirmation: "contrasenia")
InvestigationGroup.create!( id: 0, name: "no existe", create_date: DateTime.new, description: "" )
Student.create!( id: 0, provider: "unal.edu.co", uid: 0, name: "nombre", lastname: "apellido", institutional_user: "usuario", investigation_group_id: 0, password: "contrasenia", password_confirmation: "contrasenia")

for i in (1..100)

	contra = random_string(10)
	Teacher.create!( provider: "unal.edu.co", uid: i, name: random_string(10), lastname: random_string(10), institutional_user: random_string(10), password: contra, password_confirmation: contra)
	InvestigationGroup.create!( name: random_string(10), create_date: DateTime.new, description: random_string(30) )
	Tag.create!(  name: random_string(10), description: random_string(30) )

end

for i in (1..100)

	contra = random_string(10)
	Student.create!( provider: "unal.edu.co", uid: i, name: random_string(10), lastname: random_string(10), institutional_user: random_string(10), investigation_group_id: rand(100), password: contra, password_confirmation: contra)
	Event.create!( name: random_string(10), date_time: Date.today, description: random_string(40), investigation_group_id: rand(1..100))

end

for i in (1..100)

	HistoryGroup.create!( bonding_date: DateTime.new, investigation_group_id: rand(1..100), teacher_id: 0, student_id: rand(1..100), state: rand(1) )
	HistoryGroup.create!( bonding_date: DateTime.new, exit_date: DateTime.new, investigation_group_id: i, teacher_id: i, student_id: 0, state: 0 )

end

100.times do

	Contribution.create!( name: random_string(15), publication_date: DateTime.new, description: random_string(50), investigation_group_id: rand(1..100), state: rand(2) )
	Contribution.create!( name: random_string(15), publication_date: DateTime.new, description: random_string(50), investigation_group_id: rand(1..100), state: rand(2) )
	Contribution.create!( name: random_string(15), publication_date: DateTime.new, description: random_string(50), investigation_group_id: rand(1..100), state: rand(2) )

end

for i in (1..50)

	Profile.create!( entity: random_string(5), URL: random_string(30), student_id: rand(1..100), teacher_id: 0)
	Profile.create!( entity: random_string(5), URL: random_string(30), student_id: 0, teacher_id: rand(1..100))

	UserContribution.create!( student_id: rand(1..100), teacher_id: 0, contribution_id: ((i-1)*6)+1 )
	UserContribution.create!( student_id: 0, teacher_id: rand(1..100), contribution_id: ((i-1)*6)+2 )
	UserContribution.create!( student_id: rand(1..100), teacher_id: 0, contribution_id: ((i-1)*6)+3 )
	UserContribution.create!( student_id: 0, teacher_id: rand(1..100), contribution_id: ((i-1)*6)+4 )
	UserContribution.create!( student_id: rand(1..100), teacher_id: 0, contribution_id: ((i-1)*6)+5 )
	UserContribution.create!( student_id: 0, teacher_id: rand(1..100), contribution_id: ((i-1)*6)+6 )

end

for i in (1..300)

	Ubication.create!( link: random_string(50), contribution_id: i )
	Ubication.create!( link: random_string(50), contribution_id: rand(1..300) )

	TagContribution.create!( tag_id: rand(1..100), contribution_id: rand(1..300) )
	TagContribution.create!( tag_id: rand(1..100), contribution_id: i )
	TagInvestigationGroup.create!( tag_id: rand(1..100),investigation_group_id: rand(1..100) )

	UserContribution.create!( student_id: rand(1..100), teacher_id: 0, contribution_id: rand(1..300) )
	UserContribution.create!( student_id: 0, teacher_id: rand(1..100), contribution_id: rand(1..300) )

	EventStudent.create!( event_id: rand(1..100), student_id: rand(1..100) )
	EventTeacher.create!( event_id: rand(1..100), teacher_id: rand(1..100) )

end

for i in (1..100)

#	TeacherInvestigationGroup.create!( teacher_id: rand(1..100), investigation_group_id: i, rol: 2 )
#	TeacherInvestigationGroup.create!( teacher_id: rand(1..100), investigation_group_id: rand(1..100), rol: rand(1) )

end
