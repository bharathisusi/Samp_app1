class ApplicationController < ActionController::Base
  add_flash_types :error

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def append_vote_change(from_where)
    if from_where.question_box.present?
      render :json => {:html => render_to_string('/questions/_append_question_vote', :layout => false, :locals => {:question => from_where})} and return
    elsif from_where.answer.present?
      render :json => {:html => render_to_string('/answers/_append_answer_vote', :layout => false, :locals => {:answer => from_where})} and return

    end
  end
end
