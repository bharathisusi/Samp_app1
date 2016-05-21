module ApplicationHelper

  def path(ans, que)
    {id: ans.id, question_id: que}
  end
  def path1(com, que)
    {id: com.id, question_id: que}
  end






end
