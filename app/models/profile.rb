class Profile < ApplicationRecord
  belongs_to :student
  belongs_to :teacher

  validates :entity, :URL, :presence => true
  validates :URL, :uniqueness => true
end
