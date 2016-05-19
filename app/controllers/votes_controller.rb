class VotesController < ApplicationController

  def upvote
    from_where = find_votable
    if params[:upvote]
      Vote.check_if_already_voted?(current_user,from_where) ? Vote.get_current_user_vote_id(current_user,from_where) : from_where.votes.save_new_record(secure_params,current_user,params[:upvote])
    else
      Vote.check_if_already_voted?(current_user,from_where) ? Vote.get_current_user_downvote_id(current_user,from_where) : from_where.votes.save_new_record(secure_params,current_user,params[:downvote])
    end
    redirect_to :back
  end

  private

   def secure_params
    params.require(:vote).permit
  end

  def find_votable
    if params[:question_id] && params[:answer_id]
      klass = "answers"
      id = params[:answer_id]
    else
      klass = "questions"
      id = params[:question_id]
    end
    return "#{klass}".singularize.classify.constantize.find(id)
  end

end
