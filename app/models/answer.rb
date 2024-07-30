# frozen_string_literal: true

# == Schema Information
#
# Table name: answers
#
#  id          :bigint           not null, primary key
#  correct     :boolean          default(FALSE), not null
#  value       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :bigint           not null
#
# Indexes
#
#  index_answers_on_question_id  (question_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#
class Answer < ApplicationRecord
  belongs_to :question

  validates :value, presence: true

  validate :count_of_answers, on: :create

  scope :correct, -> { where(correct: true) }

  scope :by_question_id, ->(question_id) { where(question_id:) }

  private
    def count_of_answers
      count = self.class.by_question_id(question_id).count

      return if count.zero?

      errors.add(:base, 'must be between 1 and 4 answers') unless count >= 1 && count <= 4
    end
end
