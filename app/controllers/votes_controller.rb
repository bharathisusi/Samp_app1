class VotesController < ApplicationController

  def upvote
    from_where = find_votable
    current_user_upvote = Vote.check_if_already_voted?(current_user,from_where)
    if params[:upvote].present?
      current_user_upvote ? Vote.get_current_user_vote_id(current_user,from_where) : from_where.votes.save_new_record(secure_params,current_user,params[:upvote])
    else
      current_user_upvote ? Vote.get_current_user_downvote_id(current_user,from_where) : from_where.votes.save_new_record(secure_params,current_user,params[:downvote])
    end
    if params[:downvote].present?
      if current_user_upvote
        if current_user_upvote.upvote == 1
          render :json => {error: "you already voted.so you cant downvoted"} and return
        else
          append_vote_change(from_where)
        end
      else
        append_vote_change(from_where)
      end
    else
      if current_user_upvote
        if current_user_upvote.downvote == -1
          render :json => {error: "you already downvoted.so you cant voted"} and return
        else
          append_vote_change(from_where)
        end
      else
        append_vote_change(from_where)
      end
    end
  end

  private

  def secure_params
    params.require(:vote).permit(:upvote, :downvote)
  end

  def find_votable
    if params[:question_id] && params[:answer_id] && params[:comment_id]

      klass = "comments"
      id = params[:comment_id]
    elsif params[:question_id] && params[:answer_id]
      klass = "answers"
      id = params[:answer_id]
    elsif params[:question_id] && params[:comment_id]
      klass = "comments"
      id = params[:comment_id]
    else
      klass = "questions"
      id = params[:question_id]
    end
    return "#{klass}".singularize.classify.constantize.find(id)
  end

end
