module VotesHelper

  def link_to_vote(from, current_count, question, answer = nil)
    resource = answer ? answer : question

    if from == 'upvote'
      arrow_class = 'up'

      if current_user.present?
        p "1111111111111111111"
         btn = resource.votes.if_already_upvote_notify?(current_user,resource).present? ? "btn-warning" : ''
      end
    else
      arrow_class = 'down'
      if current_user.present?
        p "2222222222222222222"
        btn = resource.votes.if_already_downvote_notify?(current_user,resource).present? ? "btn-warning" : ''
      end
    end

    link_to upvote_votes_path(vote: {current_count: current_count}, question_id: question.id, answer_id: answer ? answer.id : nil, "#{from}": "#{from}"), method: :post, class: btn, remote: true, id: "submit_button", question_id: question.id do
        "<i class='fa fa-chevron-#{arrow_class}'></i>".html_safe
      end
end


  def link_to_comment_vote(from, current_count, question, comment,answer = nil)
    if from == 'upvote'
      #from ='upvote'
      arrow_class = 'up'
      if current_user.present?
        btn = comment.votes.if_already_upvote_notify?(current_user,comment).present? ? "btn-warning" : ''
      end
    else
      #from = 'downvote'
      arrow_class = 'down'
      if current_user.present?
        btn = comment.votes.if_already_downvote_notify?(current_user,comment).present? ? "btn-warning" : ''
      end
    end

    link_to upvote_votes_path(vote: {current_count: current_count}, question_id: question.id, comment_id: comment.id, answer_id: answer ? answer.id : nil, "#{from}": "#{from}"), method: :post, class: btn do
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
  # def name
  #   return last_name if self.last_name.present?
  #   return first_name if first_name.present?
  #   return email
  #   #self.last_name.present ? last_name : first_name.present ? first_name : email
  # end


end
