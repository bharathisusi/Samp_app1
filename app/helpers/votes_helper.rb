module VotesHelper

  def link_to_vote(from, current_count, question, answer = nil)
    resource = answer ? answer : question
    id_for_js = answer ? "submit_#{answer.get_object_table_name.singularize}_#{answer.id}" : "submit_#{question.get_object_table_name.singularize}_#{question.id}"
    if from == 'upvote'
      arrow_class = 'up'
      if current_user.present?
        btn = resource.votes.if_already_upvote_notify?(current_user,resource).present? ? "btn-warning" : ''
      end
    else
      arrow_class = 'down'
      if current_user.present?
        btn = resource.votes.if_already_downvote_notify?(current_user,resource).present? ? "btn-warning" : ''
      end
    end
    link_to "javascript:void();", current_count: current_count, question_id: question.id, answer_id: answer ? answer.id : nil, "#{from}": "#{from}", class: btn, id: id_for_js do
        "<i class='fa fa-chevron-#{arrow_class}'></i>".html_safe
    end
  end


  def link_to_comment_vote(from, current_count, question, comment,answer = nil)
    id_for_js = answer ? "submit_#{answer.get_object_table_name.singularize}_#{comment.get_object_table_name.singularize}_#{comment.id}" : "submit_#{question.get_object_table_name.singularize}_#{comment.get_object_table_name.singularize}_#{comment.id}"
    if from == 'upvote'
      arrow_class = 'up'
      if current_user.present?
        btn = comment.votes.if_already_upvote_notify?(current_user,comment).present? ? "btn-warning" : ''
      end
    else
      arrow_class = 'down'
      if current_user.present?
        btn = comment.votes.if_already_downvote_notify?(current_user,comment).present? ? "btn-warning" : ''
      end
    end
     link_to "javascript:void();", current_count: current_count, question_id: question.id, comment_id: comment.id, answer_id: answer ? answer.id : nil, "#{from}": "#{from}", class: btn, id: id_for_js do
        "<i class='fa fa-chevron-#{arrow_class}'></i>".html_safe
    end

    # link_to upvote_votes_path(vote: {current_count: current_count}, question_id: question.id, comment_id: comment.id, answer_id: answer ? answer.id : nil, "#{from}": "#{from}"), method: :post, class: btn do
    #   "<i class='fa fa-chevron-#{arrow_class}'></i>".html_safe
    # end
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
