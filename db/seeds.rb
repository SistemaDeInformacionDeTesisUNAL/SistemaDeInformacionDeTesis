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

for i in (1..100)

	us = random_string(10)
	Teacher.create!( first_name: random_string(10), last_name: random_string(10), email: "#{us}@unal.edu", username: us )
	InvestigationGroup.create!( name: random_string(10), create_date: Date.today, description: random_string(30) )
	Tag.create!(  name: random_string(10), description: random_string(30) )

end

for i in (1..100)

	us = random_string(10)
	group = rand(1..100)

	Student.create!( first_name: random_string(10), last_name: random_string(10), email: "#{us}@unal.edu", username: us, investigation_group_id: group )
	Event.create!( name: random_string(10), date_time: Date.today, description: random_string(40), investigation_group_id: rand(1..100))

	teach = rand(1..100)

	TeacherInvestigationGroup.create!( teacher_id: teach, investigation_group_id: i, rol: 2 )
	TeacherInvestigationGroup.create!( teacher_id: rand(1..100), investigation_group_id: rand(1..100), rol: rand(1) )

	HistoryGroup.create!( bonding_date: Date.today, investigation_group_id: group, historable_type: Student, historable_id: i, state: 0 )
	HistoryGroup.create!( bonding_date: Date.today, investigation_group_id: i, historable_type: Teacher, historable_id: teach, state: 0 )

	Contribution.create!( name: random_string(15), publication_date: Date.today, description: random_string(50), investigation_group_id: rand(1..100), state: rand(3) )
	Contribution.create!( name: random_string(15), publication_date: Date.today, description: random_string(50), investigation_group_id: rand(1..100), state: rand(3) )
	Contribution.create!( name: random_string(15), publication_date: Date.today, description: random_string(50), investigation_group_id: rand(1..100), state: rand(3) )

end

for i in (1..50)

	HistoryGroup.create!( bonding_date: Date.today, investigation_group_id: rand(1..100), historable_type: Student, historable_id: rand(1..100), state: 1 )
	HistoryGroup.create!( bonding_date: Date.today, investigation_group_id: rand(1..100), historable_type: Teacher, historable_id: rand(1..100), state: 1 )

	Profile.create!( entity: random_string(5), URL: random_string(30), profileable_type: Student, profileable_id: rand(1..100))
	Profile.create!( entity: random_string(5), URL: random_string(30), profileable_type: Teacher, profileable_id: rand(1..100))

	UserContribution.create!( userable_type: Student, userable_id: rand(1..100), contribution_id: ((i-1)*6)+1 )
	UserContribution.create!( userable_type: Teacher, userable_id: rand(1..100), contribution_id: ((i-1)*6)+2 )
	UserContribution.create!( userable_type: Student, userable_id: rand(1..100), contribution_id: ((i-1)*6)+3 )
	UserContribution.create!( userable_type: Teacher, userable_id: rand(1..100), contribution_id: ((i-1)*6)+4 )
	UserContribution.create!( userable_type: Student, userable_id: rand(1..100), contribution_id: ((i-1)*6)+5 )
	UserContribution.create!( userable_type: Teacher, userable_id: rand(1..100), contribution_id: ((i-1)*6)+6 )

end

for i in (1..300)

	Ubication.create!( link: random_string(50), contribution_id: i )
	Ubication.create!( link: random_string(50), contribution_id: rand(1..300) )

	TagContribution.create!( tag_id: rand(1..100), contribution_id: rand(1..300) )
	TagContribution.create!( tag_id: rand(1..100), contribution_id: i )
	TagInvestigationGroup.create!( tag_id: rand(1..100),investigation_group_id: rand(1..100) )

	UserContribution.create!( userable_type: Student, userable_id: rand(1..100), contribution_id: rand(1..300) )
	UserContribution.create!( userable_type: Teacher, userable_id: rand(1..100), contribution_id: rand(1..300) )

	EventStudent.create!( event_id: rand(1..100), student_id: rand(1..100) )
	EventTeacher.create!( event_id: rand(1..100), teacher_id: rand(1..100) )

end
