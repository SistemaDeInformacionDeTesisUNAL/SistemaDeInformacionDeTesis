class Profile < ApplicationRecord

    belongs_to :profileable, polymorphic: true

  	validates :entity, :URL, :presence => true
  	validates :URL, :uniqueness => true

  def self.load_profiles(**args)
    includes(:profileable).paginate(:page => args[:page],:per_page => args[:per_page])
  end

end
