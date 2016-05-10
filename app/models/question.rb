class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :answered_users, :source => :user, :through => :answers
  has_many :comments, as: :commentable
  validates :question_box, :presence => true

  def answers_count
    a= self.answers.count
    if a<=1
      "#{a} Answer"
    else
      "#{a} Answers"
    end
  end
end
