class Marker < ActiveRecord::Base
  belongs_to :member

  validates :member, presence: true

  reverse_geocoded_by :latitude, :longitude,
                      :address => :address
  after_validation :reverse_geocode
end
