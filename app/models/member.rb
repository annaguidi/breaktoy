class Member < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  has_many :markers, dependent: :destroy

  validates :group, presence: true
  validates :user, presence: true
end
