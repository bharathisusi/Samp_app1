class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :image, ImageUploader
  has_many :questions
  has_many :answers
  has_many :answered_questions, :source => :question, :through => :answers
  validates :first_name, :presence => true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :comments
  has_many :votes
  has_one :profile
  accepts_nested_attributes_for :profile

  def full_name
    "#{first_name.capitalize} #{last_name}"
  end



end
