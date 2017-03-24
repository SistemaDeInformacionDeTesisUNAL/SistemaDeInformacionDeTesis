class Ubication < ApplicationRecord
  belongs_to :contribution

  validates :link, :presence => true
  validates :link, :uniqueness => true
end
