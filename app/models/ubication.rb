class Ubication < ApplicationRecord

  belongs_to :contribution

  validates :link, :presence => true
  validates :link, :uniqueness => true
  
   def self.ubications_by_id(ubication_id)

	includes(:contribution).find_by_id(ubication_id)
  end
  
end
