class UserContribution < ApplicationRecord
  belongs_to :userable, polymorphic: true
  belongs_to :contribution

  def self.load_contributions_users(**args)
    includes(:contribution).paginate(:page=>args[:page],:per_page=>args[:per_page])
  end
end
