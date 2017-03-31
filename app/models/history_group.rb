class HistoryGroup < ApplicationRecord

	belongs_to :investigation_group
  	belongs_to :student
  	belongs_to :teacher

  	enum state: {Active: 1, Inactive: 2}

  	validates :bonding_date, :state, :presence => true
  	validates_inclusion_of :state, in: 1..2
end
