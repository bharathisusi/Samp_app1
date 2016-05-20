module VotesHelper

  def link_to_vote(current_count, question, from)
    if from == 'upvote'
      #from ='upvote'
      arrow_class = 'up'
      btn = question.votes.if_already_upvote_notify?(current_user,question).present? ? "btn-warning" : ''
    else
      #from = 'downvote'
      arrow_class = 'down'
      btn = question.votes.if_already_downvote_notify?(current_user,question).present? ? "btn-warning" : ''
    end

    link_to upvote_votes_path(vote: {current_count: current_count}, question_id: question.id, "#{from}": "#{from}"), method: :post, class: btn do
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
