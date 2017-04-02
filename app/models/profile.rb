class Profile < ApplicationRecord

    belongs_to :profileable, polymorphic: true

  	validates :entity, :URL, :presence => true
  	validates :URL, :uniqueness => true
end
