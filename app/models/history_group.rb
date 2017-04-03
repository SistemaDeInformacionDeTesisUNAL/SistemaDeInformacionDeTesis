class HistoryGroup < ApplicationRecord

	belongs_to :investigation_group
  belongs_to :historable, polymorphic: true

  enum state: {Active: 0, Inactive: 1}

  validates :bonding_date, :presence => true
  validates :state, inclusion: { in: states.keys }
end
