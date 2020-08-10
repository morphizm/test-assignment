module QuestionsHelper
  def question_header(question)
    method = question.persisted? ? 'Edit' : 'Create'
    "#{method} #{question.test.title} Question"
  end
end
