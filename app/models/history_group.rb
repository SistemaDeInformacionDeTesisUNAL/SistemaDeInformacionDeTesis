class HistoryGroup < ApplicationRecord
	attr_accessor :bonding_date, :exit_date, :state
	belongs_to :investigation_group
  	belongs_to :student
  	belongs_to :teacher

  	enum state: {Active: 0, Inactive: 1}

  	validates :bonding_date, :state, :presence => true
  	validates :state, :numericality { :only_integer => true }
  	validates :state, :numericality { :greater_than_or_equal_to => 0 }
  	validates :state, :numericality { :less_than_or_equal_to => 1 }
end
