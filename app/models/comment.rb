class Comment < ActiveRecord::Base
  include Common
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  validates :comment, :presence => true



end
