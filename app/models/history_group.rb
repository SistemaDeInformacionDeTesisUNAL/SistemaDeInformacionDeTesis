class HistoryGroup < ApplicationRecord

	belongs_to :investigation_group
  belongs_to :historable, polymorphic: true

  enum state: {Active: 0, Inactive: 1}

  validates :bonding_date, :presence => true
  validates :state, inclusion: { in: states.keys }



	#No se ha probado
  #relaciones historyGroup
  def self.history_by_id(historable_id)
	  includes(:investigation_group).find_by_id(historable_id)
  end

end
