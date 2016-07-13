class Profile < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :user

  extend FriendlyId
  friendly_id :full_name, use: :slugged

  def to_param
    "#{id}/#{full_name}"
  end


  def full_name
     "#{first_name.capitalize}-#{last_name}"
  end

  def full_name_profile
     "#{first_name.capitalize} #{last_name}"
  end



end
