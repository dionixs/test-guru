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

  scope :correct_answers, -> { where(correct: true) }

  validates :value, presence: true
end
