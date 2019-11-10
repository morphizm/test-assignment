module TestsHelper
  def question_quantity(test)
    test.questions.count
  end
end
