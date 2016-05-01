class Group < ActiveRecord::Base
  has_many :members, dependent: :destroy
  has_many :users, through: :members
  has_many :invites

  validates :name, presence: true
  validates :city, presence: true
  validates :country, presence: true

  geocoded_by :full_address
  after_validation :geocode

  def full_address
    "#{city}, #{state}, #{country}"
  end

end
