class Tag < ApplicationRecord

	has_many :tag_contributions
	has_many :contributions, through: :tag_contributions

	has_many :tag_investigation_groups
	has_many :investigation_groups, through: :tag_investigation_groups


	validates :name, :presence => true
	validates :name, :length => { :maximum => 15, :too_long => "%{count} Demasiados caracteres" }
	validates :name, :uniqueness => true
	validates :description, :length => { :maximum => 200, :too_long => "%{count} Demasiados caracteres" }

	#Retorna una lista con todos los nombres de los tags
 	def self.load_tag_names
 		list = []
 		Tag.all.each do |x|
 			list.push( x.name )
 		end
 		return list
 	end
end
