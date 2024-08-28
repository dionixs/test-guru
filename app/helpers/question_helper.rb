module QuestionHelper
  def question_header(question)
    test = question.test
    question.new_record? ? "Create New #{test.title} Question" : "Edit #{test.title} Question"
  end
end
