class Profile < ApplicationRecord

    belongs_to :profileable, polymorphic: true

  	validates :entity, :URL, :presence => true
  	validates :URL, :uniqueness => true
	
	#retorna relaciond e un perfil con un teacher o student
  def self.profiles_by_id(profile_id)

	includes(:profileable).find_by_id(profile_id)
  end

  
end
