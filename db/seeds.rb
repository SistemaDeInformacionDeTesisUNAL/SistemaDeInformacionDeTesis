# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

G = {}
for i in (1..60)
	us = Faker::Internet.unique.user_name+rand(1..10000).to_s
	Teacher.create!( first_name: Faker::Name.unique.first_name, last_name: Faker::Name.last_name, email: "#{us}@unal.edu.co", username: us, password: Faker::Internet.password(8) )
	InvestigationGroup.create!( name: Faker::Team.unique.name, create_date: Faker::Date.backward(2000), description: Faker::Lorem.sentence, image: Faker::LoremPixel.image )
	G[ i ] = [[],[],[],[]]
	Tag.create!( name: Faker::Pokemon.unique.name )
	Tag.create!( name: Faker::Pokemon.unique.name )
end

for i in (1..60)
	teach = rand(1..60)
	TeacherInvestigationGroup.create!( teacher_id: teach, investigation_group_id: i, rol: 2, state: 2 )
	HistoryGroup.create!( bonding_date: Faker::Date.backward(2000), investigation_group_id: i, historable_type: Teacher, historable_id: teach, state: 0 )
	G[ i ][ 3 ].push( teach )
end

for i in (1..300)
	us = Faker::Internet.unique.user_name+rand(1..10000).to_s
	group = rand(1..60)
	Student.create!( first_name: Faker::Name.first_name,last_name: Faker::Name.last_name, email: "#{us}@unal.edu.co", username: us, investigation_group_id: group, state: 2, password: Faker::Internet.password(8) )
	HistoryGroup.create!( bonding_date: Faker::Date.backward(2000), investigation_group_id: group, historable_type: Student, historable_id: i, state: 0 )
	G[ group ][ 0 ].push( i )
end

for i in (1..150)
	group = rand(1..60)
	teach = rand(1..60)
	TeacherInvestigationGroup.create!( teacher_id: teach, investigation_group_id: group, rol: rand(2), state: 2 )
	HistoryGroup.create!( bonding_date: Faker::Date.backward(2000), investigation_group_id: group, historable_type: Teacher, historable_id: teach, state: 0 )
	G[ group ][ 3 ].push( teach )
end

for i in (1..300)
	group = rand(1..60)
	list = rand(2)
	if list == 0
		user = Student
		id = G[ group ][ 0 ]
	else
		user = Teacher
		id = G[ group ][ 3 ]
	end
	Contribution.create!( name: Faker::Commerce.product_name, publication_date: Faker::Date.backward(2000), description: Faker::Lorem.sentence , investigation_group_id: group, state: rand(3), file: Faker::Internet.url('example.com', '/contribution.pdf'), ubication: Faker::Internet.url )
	UserContribution.create!( userable_type: user, userable_id: id[ rand( id.size ) ], contribution_id: i )
	G[ group ][1].push(i)
end

for i in ( 1..500 )
	group = rand( 1..60 )
	contr = G[ group ][ 1 ]
	list = rand( 3 )
	if list == 0
		user = Student
		id = G[ group ][ 0 ]
	elsif list == 1
		user = Student
		id = G[ group ][ 0 ]
	else
		user = Teacher
		id = G[ group ][ 3 ]
	end
	UserContribution.create!( userable_type: user, userable_id: id[ rand( id.size ) ], contribution_id: contr[ rand( contr.size ) ] )
end

for i in (1..500)
	group = rand( 1..60 )
	contr = G[ group ][ 1 ]
	tag = rand( 1..120 )
	TagContribution.create!( tag_id: tag, contribution_id: contr[ rand( contr.size ) ] )
	TagInvestigationGroup.create!( tag_id: tag, investigation_group_id: group )
	group = rand( 1..60 )
	contr = G[ group ][ 1 ]
	tag = rand( 1..120 )
	TagContribution.create!( tag_id: tag, contribution_id: contr[ rand( contr.size ) ] )
	TagInvestigationGroup.create!( tag_id: tag, investigation_group_id: group )
end

for i in (1..90)
	eventStart=Faker::Time.between(2.year.ago, 2.year.from_now, :day)
	group = rand(1..60)
	Event.create!( name:Faker::Zelda.game+rand(1..10000).to_s, start_time: eventStart, end_time: eventStart+rand(1000..800000), description: Faker::Lorem.sentence, localization: Faker::Address.building_number, investigation_group_id: group )
	G[ group ][2].push(i)
	teach = G[ group ][ 3 ]
	EventTeacher.create!( event_id: i, teacher_id: teach[ rand( teach.size ) ] )
end
for i in (1..250)
	group = rand( 1..60 )
	event = G[ group ][ 2 ]
	stud = G[ group ][ 0 ]
	if event != [] && stud != []
		EventStudent.create!( event_id: event[ rand( event.size ) ], student_id: stud[ rand( stud.size ) ] )
	end
end
for i in (1..130)
	group = rand( 1..60 )
	event = G[ group ][ 2 ]
	teach = G[ group ][ 3 ]
	if event != []
		EventTeacher.create!( event_id: event[ rand( event.size ) ], teacher_id: teach[ rand( teach.size ) ] )
	end
end
