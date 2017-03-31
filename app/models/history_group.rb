class HistoryGroup < ApplicationRecord

	belongs_to :investigation_group
  belongs_to :student
	belongs_to :teacher

  enum status: [ :Active, :Inactive ]

  validates :bonding_date, :presence => true
	validates :state, :presence => true
	validates_inclusion_of :state, in: 0..1
end
