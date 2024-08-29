class AddCorrectQuestionsToUserTests < ActiveRecord::Migration[7.1]
  def change
    add_column :user_tests, :correct_questions, :integer, default: 0, null: false
  end
end
