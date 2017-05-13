class Tag < ApplicationRecord

	has_many :tag_contributions
	has_many :contributions, through: :tag_contributions

	has_many :tag_investigation_groups
	has_many :investigation_groups, through: :tag_investigation_groups


	validates :name, :presence => true
	validates :name, :length => { :maximum => 15, :too_long => "%{count} Demasiados caracteres" }
	validates :name, :uniqueness => true

	def self.load_tags_contribution(**args)
		TagContribution.where(tag_id: args[:ids], contribution_id: args[:contr] )
	end

	def self.tag_in_contribution(**args)
		TagContribution.where(contribution_id: args[:contr] )
	end
	
	def self.tags_contribution(**args)
		tags = TagContribution.where( contribution_id: args[:contr] )
		list = []
		tags.each do |tag|
			taged = Tag.find( tag.tag_id )
			list.push( taged )
		end
		return list
	end

	def self.load_tags_invGroup(**args)
		TagInvestigationGroup.where(tag_id: args[:ids], investigation_group_id: args[:inv] )
	end

	#Retorna una lista con todos los nombres de los tags
	def self.load_tag_names
		list = []
		Tag.all.each do |x|
			list.push( x.name )
		end
		return list
	end

end
