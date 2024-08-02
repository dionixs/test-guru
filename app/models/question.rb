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

  validates :answers, length: { minimum: 0, maximum: 4 }
end
