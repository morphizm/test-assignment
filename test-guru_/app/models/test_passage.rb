class TestPassage < ApplicationRecord
  SUCCESS = 85

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :set_current_question

  scope :user_tests, ->(trial, user) { where(test: trial, user: user) }

  def completed?
    current_question.nil?
  end

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)
    self.current_question = nil if spent_time?
    save!
    update(successful: true) if completed? && passed?
  end

  def total
    questions = test.questions.count
    correct_questions / questions.to_f * 100
  end

  def passed?
    total >= SUCCESS
  end

  def current_question_number
    test.questions.where('id <= ?', current_question.id).count
  end

  def spent_time?
    return left_time <= 0 if test.timer
  end

  def left_time
    if test.timer
      (created_at + test.timer.hour.hour + test.timer.min.minute) - Time.now
    end
  end

  private

  def correct_answer?(answer_ids)
    correct_answers_count = correct_answers.count

    (correct_answers_count == correct_answers.where(id: answer_ids).count) && correct_answers_count == answer_ids.count
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    if new_record?
      test.questions.first
    elsif current_question
      test.questions.order(:id).where('id > ?', current_question.id).first
    end
  end

  def set_current_question
    self.current_question = next_question
  end
end
