class HistoryGroup < ApplicationRecord

	belongs_to :investigation_group
  belongs_to :historable, polymorphic: true

  enum state: {Active: 0, Inactive: 1}

  validates :bonding_date, :presence => true
  validates :state, inclusion: { in: states.keys }

	def self.load_historys
		includes(:historable)
	end
	def self.load_actives_historys(**args)
		load_historys.where( historable_type: args[:type], historable_id: args[:ids], investigation_group_id: args[:group], state: 0 )
	end
end
