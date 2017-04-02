# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#t= teacher.create(:name=>"Pedro", :lastname=>"perez",:institutional_user=>"pperezq@unal.edu.co")
#teacher.new(:name=>"Pedro", :lastname=>"perez",:institutional_user=>"pperezq@unal.edu.co");
#t= contribution.create(:name=> "tesis1 cuantica",:description=>"computacion cuantica",:state=>1)
#t= tag.create(:name=>"cuantica")
#t= investigation_group.create(:name=>"investigacion computacion")
#t= contribution.load_contributions(1)
#=======
aleatorio = Random.new

def random_string(length=10)
	chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789'
	password = ''
	length.times { password << chars[rand(chars.size)] }
	return password
end

for i in (1..100)

	contra = random_string(10)
	Teacher.create!( provider: "unal.edu.co", uid: 1, name: random_string(10), lastname: random_string(10), institutional_user: random_string(10), password: contra, password_confirmation: contra)
#	InvestigationGroup.create!( name: random_string(10), create_date: DateTime.new, description: random_string(30) )
	InvestigationGroup.create!( name: random_string(10), description: random_string(30) )
	Tag.create!(  name: random_string(10), description: random_string(30) )

end

for i in (1..100)

	contra = random_string(10)
	Student.create!( provider: "unal.edu.co", uid: i, name: random_string(10), lastname: random_string(10), institutional_user: random_string(10), investigation_group_id:  aleatorio.rand(1..100), password: contra, password_confirmation: contra)
	#Event.create!( id:3, name: random_string(10), date_time: DateTime.new(2016,  aleatorio.rand(1..12),  aleatorio.rand(1..30),  aleatorio.rand(1..20),  aleatorio.rand(1..50), 0), description: random_string(40), investigation_groups_id:  aleatorio.rand(1..100))
	Event.create!( id:3, name: random_string(10), description: random_string(40), investigation_group_id:  1)

end

for i in (1..100)

	HistoryGroup.create!( bonding_date: DateTime.new, exit_date: DateTime.new, investigation_group_id:  aleatorio.rand(1..100),student_id:  aleatorio.rand(1..100),state:  aleatorio.rand(1..2))
	HistoryGroup.create!( bonding_date: DateTime.new, exit_date: DateTime.new, investigation_group_id: i,teacher_id: i)

end

for i in (1..100)

	Contribution.create!( name: random_string(15), publication_date: DateTime.new, description: random_string(50), investigation_group_id:  aleatorio.rand(1..100), state:  aleatorio.rand(1..3))
	Contribution.create!( name: random_string(15), publication_date: DateTime.new, description: random_string(50), investigation_group_id:  aleatorio.rand(1..100), state:  aleatorio.rand(1..3))
	Contribution.create!( name: random_string(15), publication_date: DateTime.new, description: random_string(50), investigation_group_id:  aleatorio.rand(1..100), state:  aleatorio.rand(1..3))


	TeacherInvestigationGroup.create!( teacher_id:  aleatorio.rand(1..100), investigation_group_id:  aleatorio.rand(1..100),rol:  aleatorio.rand(1..2) )
	TeacherInvestigationGroup.create!( teacher_id: i, investigation_group_id: i, rol: 3 )

end

for i in (1..50)

	Profile.create!( entity: random_string(5), URL: random_string(30), student_id:  aleatorio.rand(1..100))
	Profile.create!( entity: random_string(5), URL: random_string(30), teacher_id:  aleatorio.rand(1..100))

	UserContribution.create!( student_id:  aleatorio.rand(1..100),contribution_id: ((i-1)*6)+1 )
	UserContribution.create!( teacher_id:  aleatorio.rand(1..100),contribution_id: ((i-1)*6)+2 )
	UserContribution.create!( student_id:  aleatorio.rand(1..100),contribution_id: ((i-1)*6)+3 )
	UserContribution.create!( teacher_id:  aleatorio.rand(1..100),contribution_id: ((i-1)*6)+4 )
	UserContribution.create!( student_id:  aleatorio.rand(1..100),contribution_id: ((i-1)*6)+5 )
	UserContribution.create!( teacher_id:  aleatorio.rand(1..100),contribution_id: ((i-1)*6)+6 )

end

for i in (1..300)

	Ubication.create!( link: random_string(50), contribution_id: i )
	Ubication.create!( link: random_string(50), contribution_id:  aleatorio.rand(1..300) )

	TagContribution.create!( tag_id:  aleatorio.rand(1..100), contribution_id:  aleatorio.rand(1..300) )
	TagContribution.create!( tag_id:  aleatorio.rand(1..100), contribution_id: i )
	TagInvestigationGroup.create!( tag_id:  aleatorio.rand(1..100),investigation_group_id:  aleatorio.rand(1..100) )

	UserContribution.create!( student_id:  aleatorio.rand(1..100),contribution_id:  aleatorio.rand(1..300) )
	UserContribution.create!( teacher_id:  aleatorio.rand(1..100),contribution_id:  aleatorio.rand(1..300) )

	EventStudent.create!( event_id:  aleatorio.rand(1..100),student_id:  aleatorio.rand(1..100) )
	EventTeacher.create!( event_id:  aleatorio.rand(1..100),teacher_id:  aleatorio.rand(1..100) )

end

