module QuestionHelper
  def question_header(test)
    action_name == 'new' ? "Create New #{test.title} Question" : "Edit #{test.title} Question"
  end
end
