class Profile < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :user
  def full_name
    "#{first_name} #{last_name}"
  end


end
