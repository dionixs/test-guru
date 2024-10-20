# frozen_string_literal: true

class CreateUserTests < ActiveRecord::Migration[7.1]
  def change
    create_table :user_tests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :test, null: false, foreign_key: true
      t.index [:user_id, :test_id], unique: true

      t.timestamps
    end
  end
end
