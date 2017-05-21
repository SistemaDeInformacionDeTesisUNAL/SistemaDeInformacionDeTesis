# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
InvestigationGroup.create!( id: 0, name: "Grupo creado", create_date: Faker::Date.backward(2000), description: Faker::Lorem.sentence, image: Faker::LoremPixel.image )

for i in (1..100)
	us = Faker::Internet.unique.user_name+rand(1..10000).to_s
	Teacher.create!( first_name: Faker::Name.unique.first_name, last_name: Faker::Name.last_name, email: "#{us}@unal.edu.co", username: us, password: Faker::Internet.password(8) )
	InvestigationGroup.create!( name: Faker::Team.unique.name, create_date: Faker::Date.backward(2000), description: Faker::Lorem.sentence, image: Faker::LoremPixel.image )
	Tag.create!( name: Faker::Pokemon.unique.name+rand(1..10000).to_s, description: Faker::Lorem.sentence )
end


for i in (1..100)

	us = Faker::Internet.unique.user_name+rand(1..10000).to_s
	group = rand(1..100)

	eventStart=Faker::Time.between(2.days.ago, Date.today, :day)
	Student.create!( first_name: Faker::Name.first_name,last_name: Faker::Name.last_name, email: "#{us}@unal.edu.co", username: us, investigation_group_id: group, state: 2, password: Faker::Internet.password(8) )
	Event.create!( name:Faker::Zelda.game+rand(1..10000).to_s, start_time: eventStart, end_time: eventStart+rand(1000..800000), description: Faker::Lorem.sentence, investigation_group_id: rand(1..100))
end

for i in (1..100)

	Contribution.create!( name: Faker::Commerce.product_name, publication_date: Faker::Date.backward(2000), description: Faker::Lorem.sentence , investigation_group_id: rand(1..100), state: rand(3), file: Faker::Internet.url('example.com', '/contribution.pdf') )
	Contribution.create!( name: Faker::Commerce.product_name, publication_date: Faker::Date.backward(2000), description: Faker::Lorem.sentence , investigation_group_id: rand(1..100), state: rand(3), file: Faker::Internet.url('example.com', '/contribution.pdf') )
	Contribution.create!( name: Faker::Commerce.product_name, publication_date: Faker::Date.backward(2000), description: Faker::Lorem.sentence , investigation_group_id: rand(1..100), state: rand(3), file: Faker::Internet.url('example.com', '/contribution.pdf') )

end

for i in (1..100)
	teach = rand(1..100)
	TeacherInvestigationGroup.create!( teacher_id: teach, investigation_group_id: i, rol: 2, state: 2 )
	TeacherInvestigationGroup.create!( teacher_id: rand(1..100), investigation_group_id: rand(1..100), rol: rand(1), state: 2 )


	HistoryGroup.create!( bonding_date: Faker::Date.backward(2000), investigation_group_id: i, historable_type: Teacher, historable_id: teach, state: 0 )
	HistoryGroup.create_with(bonding_date: Faker::Date.backward(2000), investigation_group_id: teach, historable_type: Student, historable_id: i, state: 0 ).find_or_create_by(id: i)
end

for i in (1..50)

	HistoryGroup.create!( bonding_date: Faker::Date.backward(2000), investigation_group_id: rand(1..100), historable_type: Student, historable_id: rand(1..100), state: 1 )
	HistoryGroup.create!( bonding_date: Faker::Date.backward(2000), investigation_group_id: rand(1..100), historable_type: Teacher, historable_id: rand(1..100), state: 1 )

	Profile.create!( entity: Faker::Internet.domain_word, URL: Faker::Internet.url, profileable_type: Student, profileable_id: rand(1..100))
	Profile.create!( entity: Faker::Internet.domain_word, URL: Faker::Internet.url, profileable_type: Teacher, profileable_id: rand(1..100))

	UserContribution.create!( userable_type: Student, userable_id: rand(1..100), contribution_id: ((i-1)*6)+1 )
	UserContribution.create!( userable_type: Teacher, userable_id: rand(1..100), contribution_id: ((i-1)*6)+2 )
	UserContribution.create!( userable_type: Student, userable_id: rand(1..100), contribution_id: ((i-1)*6)+3 )
	UserContribution.create!( userable_type: Teacher, userable_id: rand(1..100), contribution_id: ((i-1)*6)+4 )
	UserContribution.create!( userable_type: Student, userable_id: rand(1..100), contribution_id: ((i-1)*6)+5 )
	UserContribution.create!( userable_type: Teacher, userable_id: rand(1..100), contribution_id: ((i-1)*6)+6 )

end

for i in (1..300)

	Ubication.create!( link: Faker::Internet.url, contribution_id: i )
	Ubication.create!( link: Faker::Internet.url, contribution_id: rand(1..300) )

	TagContribution.create!( tag_id: rand(1..100), contribution_id: rand(1..300) )
	TagContribution.create!( tag_id: rand(1..100), contribution_id: i )
	TagInvestigationGroup.create!( tag_id: rand(1..100),investigation_group_id: rand(1..100) )

	UserContribution.create!( userable_type: Student, userable_id: rand(1..100), contribution_id: rand(1..300) )
	UserContribution.create!( userable_type: Teacher, userable_id: rand(1..100), contribution_id: rand(1..300) )

	EventStudent.create!( event_id: rand(1..100), student_id: rand(1..100) )
	EventTeacher.create!( event_id: rand(1..100), teacher_id: rand(1..100) )

end
