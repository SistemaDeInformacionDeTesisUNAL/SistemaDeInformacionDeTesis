class Tag < ApplicationRecord
	attr_accessor :name, :description		
	end
	has_many :tag_contributions
	has_many :contributions, through: :tag_contributions

	has_many :tag_investigation_groups
	has_many :investigation_groups, through: :tag_investigation_groups


	validates :name, :publication_date, :state, :presence => true
	validates :name, :length => { :maximum => 15, :too_long => "%{count} Demasiados caracteres" }
	validates :name, :uniqueness => true
	validates :description, :length => { :maximum => 200, :too_long => "%{count} Demasiados caracteres" }
end
