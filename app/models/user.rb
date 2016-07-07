class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :questions
  has_many :answers
  has_many :answered_questions, :source => :question, :through => :answers
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :comments
  has_many :votes
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile



end
