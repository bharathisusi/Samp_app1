class Vote < ActiveRecord::Base
  belongs_to :votable, polymorphic: true
  belongs_to :user

  def init_upvote
    self.upvote = 1
  end

  def init_downvote
    self.downvote = -1
  end

  def back_to_zero
    self.upvote = 0
  end

  def update_if_already_voted
    update_attributes(upvote: 0)
  end

  def update_if_already_voted_with_zero
    update_attributes(upvote: 1)
  end

  def update_if_already_downvoted
    update_attributes(downvote: 0)
  end

  def update_if_already_downvoted_with_zero
    update_attributes(downvote: -1)
  end

  def append_vote_change
    render :json => {:html => render_to_string('/questions/_append_question_vote', :layout => false, :locals => {:question => self})} and return
  end

  class << self

    def check_if_already_voted?(current_user,votable)
      where(user_id: current_user.id, votable_id: votable.id, votable_type: votable.get_class_name).first
    end

    def if_already_upvote_notify?(current_user,votable)
      where(user_id: current_user.id, votable_id: votable.id, upvote: 1, votable_type: votable.get_class_name).first
    end

    def if_already_downvote_notify?(current_user,votable)
      where(user_id: current_user.id, votable_id: votable.id, downvote: -1, votable_type: votable.get_class_name).first
    end

    def get_current_user_vote_id(current_user,votable)
      vote = check_if_already_voted?(current_user,votable)
      if vote.downvote == 0 || vote.downvote == nil
        vote.upvote == 0 ? vote.update_if_already_voted_with_zero : vote.update_if_already_voted
      end
    end

    def get_current_user_downvote_id(current_user,votable)
      vote = check_if_already_voted?(current_user,votable)
      if vote.upvote == nil || vote.upvote == 0
        vote.downvote == 0 ? vote.update_if_already_downvoted_with_zero : vote.update_if_already_downvoted
      end
    end

    def save_new_record(secure_params, current_user, upvote)
      vote_up = self.new(secure_params)
      upvote == 'upvote' ? vote_up.init_upvote : vote_up.init_downvote
      vote_up.user = current_user
      vote_up.save!
    end

    def sum_of_upvote
      sum(:upvote)
    end

    def sum_of_downvote
      sum(:downvote)
    end
  end

end
