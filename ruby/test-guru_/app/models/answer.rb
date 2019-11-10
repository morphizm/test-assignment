class Answer < ApplicationRecord
  ANSWER_LIMIT = 4

  belongs_to :question

  validates :title, presence: true
  validate :question_answers, on: :create

  scope :correct, -> { where(correct: true) }

  private

  def question_answers
    answers_count = question.answers.count
    if answers_count >= ANSWER_LIMIT
      errors.add(:question_id, 'Question can not contain more than 4 answers')
    end
  end
end
