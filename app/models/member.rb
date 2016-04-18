class Member < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  has_many :markers

  validates :group, presence: true
  validates :user, presence: true
end
