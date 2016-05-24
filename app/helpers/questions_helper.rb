module QuestionsHelper
  # def question_error_messages!
  #  return '' if @question.errors.empty?
  #  flash.now[:error] = @question.errors.full_messages.map { |msg| "#{msg}." }[0]
  # end

  def recent_question_update
    p "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    p @question
    Question.show_history(@question).question_box.html_safe
  end
end
