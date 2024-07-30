# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  value      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  test_id    :bigint           not null
#
# Indexes
#
#  index_questions_on_test_id  (test_id)
#
# Foreign Keys
#
#  fk_rails_...  (test_id => tests.id)
#
class Question < ApplicationRecord
  belongs_to :test

  has_many :answers, dependent: :delete_all

  validates :value, presence: true

  validate :count_of_answers

  private

  def count_of_answers
    return if answers.size.between?(1, 4) || answers.size.zero?

    errors.add(:base, 'must be between 1 and 4 answers')
  end
end
