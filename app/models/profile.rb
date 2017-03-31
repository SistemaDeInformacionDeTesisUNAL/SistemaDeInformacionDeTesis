class Profile < ApplicationRecord
	attr_accessor :entity, :URL
  	belongs_to :student
  	belongs_to :teacher

  	validates :entity, :URL, :presence => true
  	validates :URL, :uniqueness => true
end
