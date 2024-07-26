# frozen_string_literal: true

# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  correct     :boolean          default(FALSE), not null
#  value       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :integer          not null
#
# Indexes
#
#  index_answers_on_question_id  (question_id)
#
# Foreign Keys
#
#  question_id  (question_id => questions.id)
#
class Answer < ApplicationRecord
  belongs_to :question
end
