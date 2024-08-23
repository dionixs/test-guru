module QuestionHelper
  def question_header(test)
    test.new_record? ? "Create New #{test.title} Question" : "Edit #{test.title} Question"
  end
end
