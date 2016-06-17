class Comment < ActiveRecord::Base
  include Common
  has_many :votes, as: :votable, dependent: :destroy
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :histories, as: :historiable
  validates :comment, :presence => true



end
