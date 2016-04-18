class Marker < ActiveRecord::Base
  belongs_to :member

  validates :member, presence: true
end
