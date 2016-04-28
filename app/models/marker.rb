class Marker < ActiveRecord::Base
  belongs_to :member

  validates :member, presence: true

  mount_uploader :img_url, ImageUploader

  validates_processing_of :img_url
  validate :img_url_size_validation

  private

  def img_url_size_validation
    errors[:img_url] << "should be less than 500KB" if img_url.size > 0.5.megabytes
  end
end
