class HistoryGroup < ApplicationRecord

	belongs_to :investigation_group
  	belongs_to :student
  	belongs_to :teacher

  	enum state: {Active: 0, Inactive: 1}

  	validates :bonding_date, :state, :presence => true
  	validates_inclusion_of :state, in: 0..1
end
