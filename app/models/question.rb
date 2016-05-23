class Question < ActiveRecord::Base
  include Common
  belongs_to :user
  has_many :votes, as: :votable, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :answered_users, :source => :user, :through => :answers
  has_many :comments, as: :commentable
  validates_length_of :title, minimum: 3

  # validates_length_of :question_box, :minimum => 2, :maximum => 5, :allow_blank => false
#   validates :title, length: {is: 5}, allow_blank: false



  def answers_count
    a= self.answers.count
    if a<=1
      "#{a} Answer"
    else
      "#{a} Answers"
    end
  end

end
