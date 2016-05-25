class VotesController < ApplicationController

  def upvote
    p "hariiiiiiiiiiiiiiiiiii"
    p find_votable
    from_where = find_votable
    current_user_upvote = Vote.check_if_already_voted?(current_user,from_where)
    if params[:upvote]
      current_user_upvote ? Vote.get_current_user_vote_id(current_user,from_where) : from_where.votes.save_new_record(secure_params,current_user,params[:upvote])
    else
      current_user_upvote ? Vote.get_current_user_downvote_id(current_user,from_where) : from_where.votes.save_new_record(secure_params,current_user,params[:downvote])
    end
    if params[:downvote]
      if current_user_upvote
        if current_user_upvote.upvote == 1
          redirect_to :back, error: "you already voted.so you cant downvoted"
        else
          redirect_to :back
        end
      else
        redirect_to :back
      end
    else
      if current_user_upvote
        if current_user_upvote.downvote == -1
          redirect_to :back, error: "you already downvoted.so you cant voted"
        else
          redirect_to :back
        end
      else
        # redirect_to :back
        render :json => {:html => render_to_string('/questions/_append_question_vote', :locals => {:question => from_where})} and return
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
    p "abiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii"

    p "#{klass}".singularize.classify.constantize.find(id)
    return "#{klass}".singularize.classify.constantize.find(id)

  end
end
