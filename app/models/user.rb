class User < ActiveRecord::Base
  has_one :profile, dependent: :destroy
  has_many :members
  has_many :groups, through: :members
  has_many :invites
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :build_default_profile

  private

   def build_default_profile
     build_profile
     true
   end
end
