# frozen_string_literal: true

class AddProgressToUserTests < ActiveRecord::Migration[7.1]
  def change
    add_column :user_tests, :progress, :integer, default: 0
  end
end
