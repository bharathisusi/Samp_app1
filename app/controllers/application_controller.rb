class ApplicationController < ActionController::Base
  add_flash_types :error

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def append_vote_change(from_where)
    singular_object = from_where.get_object_table_name.singularize
    if singular_object == 'comment'
      query_object =  from_where.commentable_type == 'Answer' ? [from_where.commentable.question, from_where.commentable, 'answer'] : [from_where.commentable, nil, 'question']
      render json: {html: render_to_string("/#{singular_object.pluralize}/_trigger_#{query_object[2]}_#{singular_object}_vote", layout: false, locals: {"question": query_object[0],"answer": query_object[1], "#{singular_object}": from_where})} and return
    else
      query_object = singular_object == 'answer' ? [from_where.question, from_where, 'question'] : [from_where,nil, 'question']

      render json: {html: render_to_string("/#{singular_object.pluralize}/_trigger_#{singular_object}_vote", layout: false, locals: {"question": query_object[0], "answer": query_object[1]})} and return
    end
  end

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:Firstname,:lastname,:email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:Firstname,:lastname,:email, :password, :password_confirmation, :current_password, :image, :image_cache, :remove_image, :profile_attributes => [:tag, :organization, :country, :state, :city, :description]) }
  end

end
