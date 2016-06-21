class Question < ActiveRecord::Base
  include Common
  belongs_to :user
  has_many :votes, as: :votable, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :answered_users, :source => :user, :through => :answers
  has_many :comments, as: :commentable
  has_many :histories, as: :historiable, dependent: :destroy
  validates :title, :presence => true
  validates_length_of :title, :minimum => 3, :maximum => 100, :allow_blank => false
  validate :question_box_validation
  acts_as_taggable

  def answers_count
    a= self.answers.count
    if a<=1
      "#{a} Answer"
    else
      "#{a} Answers"
    end
  end

  def question_box_validation
    question_box_squish_method = ActionView::Base.full_sanitizer.sanitize(self.question_box).squish
    if question_box_squish_method.size > 500
      errors.add(:question_box, "is too long,maximum 100 characters only allowed")
    end
  end
  # def tag_list
  #   self.tags.map(&:name).join(', ')
  # end

  # def self.pages(page, per_page)
  #   paginate(page: page, per_page: per_page)
  # end

end
