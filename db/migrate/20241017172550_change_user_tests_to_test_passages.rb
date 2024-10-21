class ChangeUserTestsToTestPassages < ActiveRecord::Migration[7.1]
  def up
    rename_table :user_tests, :test_passages
    remove_index :test_passages, [:user_id, :test_id]
  end

  def down
    rename_table :test_passages, :user_tests
    add_index :test_passages, [:user_id, :test_id], unique: true
  end
end
