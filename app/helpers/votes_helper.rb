module VotesHelper

  def link_to_question_answer_vote(from, current_count, question, answer = 0)
    if answer == 0
      if from == 'upvote'
        arrow_class = 'up'
        btn = question.votes.if_already_upvote_notify?(current_user,question).present? ? "btn-warning" : ''
      else
        arrow_class = 'down'
        btn = question.votes.if_already_downvote_notify?(current_user,question).present? ? "btn-warning" : ''
      end

      link_to upvote_votes_path("#{from}": "#{from}", vote: {current_count: current_count}, question_id: question.id), method: :post, class: btn do
        "<i class='fa fa-chevron-#{arrow_class}'></i>".html_safe
      end
    else
      if from == 'upvote'
        arrow_class = 'up'
        btn = answer.votes.if_already_upvote_notify?(current_user,answer).present? ? "btn-warning" : ''
      else
        arrow_class = 'down'
        btn = answer.votes.if_already_downvote_notify?(current_user,answer).present? ? "btn-warning" : ''
      end

      link_to upvote_votes_path("#{from}": "#{from}", vote: {current_count: current_count}, question_id: question.id, answer_id: answer.id), method: :post, class: btn do
        "<i class='fa fa-chevron-#{arrow_class}'></i>".html_safe
      end
    end
  end



  def link_to_question_comment_vote(current_count, question, comment, from)
    if from == 'upvote'
      #from ='upvote'
      arrow_class = 'up'
      btn = comment.votes.if_already_upvote_notify?(current_user,comment).present? ? "btn-warning" : ''
    else
      #from = 'downvote'
      arrow_class = 'down'
      btn = comment.votes.if_already_downvote_notify?(current_user,comment).present? ? "btn-warning" : ''
    end

    link_to upvote_votes_path(vote: {current_count: current_count}, question_id: question.id, comment_id: comment.id, "#{from}": "#{from}"), method: :post, class: btn do
      "<i class='fa fa-chevron-#{arrow_class}'></i>".html_safe
    end
  end


  def link_to_answer_comment_vote(current_count, question, answer, comment, from)
    if from == 'upvote'
      #from ='upvote'
      arrow_class = 'up'
      btn = comment.votes.if_already_upvote_notify?(current_user,comment).present? ? "btn-warning" : ''
    else
      #from = 'downvote'
      arrow_class = 'down'
      btn = comment.votes.if_already_downvote_notify?(current_user,comment).present? ? "btn-warning" : ''
    end

    link_to upvote_votes_path(vote: {current_count: current_count}, question_id: question.id, answer_id: answer.id, comment_id: comment.id, "#{from}": "#{from}"), method: :post, class: btn do
      "<i class='fa fa-chevron-#{arrow_class}'></i>".html_safe
    end
  end

  def calculate_upvote(question)
    question.votes.sum_of_upvote
  end

  def calculate_downvote(question)
    question.votes.sum_of_downvote
  end

  def display_sum_of_votes(question)
    calculate_upvote(question) + calculate_downvote(question)

  end


end
