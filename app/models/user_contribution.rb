class UserContribution < ApplicationRecord
  belongs_to :userable, polymorphic: true
  belongs_to :contribution

  #Carga todas las contribuciones
  def self.load_users(**args)
    includes(:userable).paginate(:page => args[:page],:per_page => args[:per_page])
  end
end
