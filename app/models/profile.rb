class Profile < ApplicationRecord

    belongs_to :profileable, polymorphic: true

  	validates :entity, :URL, :presence => true
  	validates :URL, :uniqueness => true
	
   def self.load_profiles(**args)
	 includes(:entity, :URL)
   end
   
   def self.profiles_by_id(id)
	includes(:entity,:URL).find_by_id(:id)
   end
   
   def self.profiles_teacher(teacher_id,**args)
	load_teachers(args).where("profiles.teacher_id LIKE ?", "#{teacher_id}%")
   end
end
