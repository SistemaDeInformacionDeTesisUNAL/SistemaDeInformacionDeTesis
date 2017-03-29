class Ubication < ApplicationRecord
	attr_accessible :link
  belongs_to :contribution

  validates :link, :presence => true
  validates :link, :uniqueness => true
end
