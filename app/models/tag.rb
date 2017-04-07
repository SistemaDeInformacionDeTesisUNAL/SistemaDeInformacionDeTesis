class Tag < ApplicationRecord

	has_many :tag_contributions
	has_many :contributions, through: :tag_contributions

	has_many :tag_investigation_groups
	has_many :investigation_groups, through: :tag_investigation_groups


	validates :name, :presence => true
	validates :name, :length => { :maximum => 15, :too_long => "%{count} Demasiados caracteres" }
	validates :name, :uniqueness => true
	validates :description, :length => { :maximum => 200, :too_long => "%{count} Demasiados caracteres" }



	#No se han probado
	  #Devuelve los tags de una contribucion
  def self.contributions_by_tag(tag_id,page=1, per_page=3)
    Tag.find_by_id(tag_id).contribution_ids.each do |n|
		puts "Id tag:" + n.to_s
		puts "Id contribucion:" + Contribution.find_by_id(n).id.to_s
		puts "name contribucion:" + Contribution.find_by_id(n).name

		puts "description:" + Contribution.find_by_id(n).description

	end
  end
		  #Devuelve los tags de un grupo de investigacion
  def self.groups_by_tag(group_id,page=1, per_page=3)
    Tag.find_by_id(group_id).investigation_group_ids.each do |n|
		puts "Id Tag:" + n.to_s
		puts "Id Group:" + InvestigationGroup.find_by_id(n).id.to_s
		puts "name Group:" + InvestigationGroup.find_by_id(n).name

		puts "description:" + InvestigationGroup.find_by_id(n).description

	end
  end



end
