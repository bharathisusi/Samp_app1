module QuestionsHelper
  def recent_question_update(question)
    Question.show_history(question).question_box.html_safe
  end

  def question_pagination
    param = params[:per_page]
    content_tag(:ul, class: ["pagination", "pagination"]) do
      if param == '5'
        li_tag(param)
      elsif param == '10'
        li_tag(param)
      elsif param == '20'
        li_tag(param)
      else
        li_tag(param)
      end
    end
  end

  def li_tag(active="")
    links = ""
    links += "#{content_tag(:li, class: "#{active == '5' ? 'active' : ''}") do
        link_to(5, '/questions?per_page=5', :rel => 'next')
      end}"
    links += "#{content_tag(:li, class: "#{active == '10' ? 'active' : ''}") do
        link_to(10, '/questions?per_page=10', :rel => 'next')
      end}"
    links += "#{content_tag(:li, class: "#{active == '20' ? 'active' : ''}") do
        link_to(20, '/questions?per_page=20', :rel => 'next')
      end}"
    links += "#{content_tag(:li, class: "#{active == '30' ? 'active' : ''}") do
        link_to(30, '/questions?per_page=30', :rel => 'next')
      end}"
    links.html_safe
  end
end

