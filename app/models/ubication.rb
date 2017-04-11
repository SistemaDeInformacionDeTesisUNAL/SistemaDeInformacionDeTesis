class Ubication < ApplicationRecord

  belongs_to :contribution

  validates :link, :presence => true
  validates :link, :uniqueness => true

  #carga todas las contribuciones
  def self.load_ubications(**args)
    includes(:contribution).paginate(:page => args[:page],:per_page => args[:per_page])
  end 

end
