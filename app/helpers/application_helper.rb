module ApplicationHelper

  def path(ans, que)
    {id: ans.id, question_id: que}
  end

  def path1(com, que)
    {id: com.id, question_id: que}
  end

  def all_views_side_error_messages!(resource)
    return '' if resource.errors.empty?
    flash.now[:error] = resource.errors.full_messages.map { |msg| "#{msg}." }[0]
  end





end
