# frozen_string_literal: true

# == Schema Information
#
# Table name: test_passages
#
#  id                  :bigint           not null, primary key
#  correct_question    :integer          default(0)
#  progress            :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  current_question_id :bigint
#  test_id             :bigint           not null
#  user_id             :bigint           not null
#
# Indexes
#
#  index_test_passages_on_current_question_id  (current_question_id)
#  index_test_passages_on_test_id              (test_id)
#  index_test_passages_on_user_id              (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (current_question_id => questions.id)
#  fk_rails_...  (test_id => tests.id)
#  fk_rails_...  (user_id => users.id)
#
class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test

  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :set_current_question

  def accept!(answer_ids)
    self.correct_question += 1 if correct_answer?(answer_ids)
    save!
  end

  def completed?
    current_question.nil?
  end

  def percentage
    (correct_question.to_f / total_questions_count) * 100
  end

  def success?
    percentage >= 0.85
  end

  private

  def set_current_question
    self.current_question = next_question
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == answer_ids.to_a.map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    if current_question.nil?
      test.questions.first
    else
      test.questions.order(:id).where('id > ?', current_question.id).first
    end
  end

  def total_questions_count
    test.questions.count
  end
end
