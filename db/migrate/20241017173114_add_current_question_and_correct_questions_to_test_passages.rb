# frozen_string_literal: true

class AddCurrentQuestionAndCorrectQuestionsToTestPassages < ActiveRecord::Migration[7.1]
  def up
    add_reference :test_passages, :current_question, foreign_key: { to_table: :questions }, null: true
    add_column :test_passages, :correct_question, :integer, default: 0
  end

  def down
    remove_reference :test_passages, :current_question
    remove_column :test_passages, :correct_question
  end
end
