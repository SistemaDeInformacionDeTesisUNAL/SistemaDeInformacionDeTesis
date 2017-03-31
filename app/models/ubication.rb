class Ubication < ApplicationRecord
	#attr_accessor :link
  belongs_to :contribution

  validates :link, :presence => true
  validates :link, :uniqueness => true
end
