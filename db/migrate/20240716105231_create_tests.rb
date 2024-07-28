# frozen_string_literal: true

class CreateTests < ActiveRecord::Migration[7.1]
  def change
    create_table :tests do |t|
      t.string :title, null: false
      t.integer :level, null: false, default: 0

      t.references :category, null: false, foreign_key: { on_delete: :cascade }
      t.references :author, null: false, foreign_key: { to_table: :users, on_delete: :cascade }

      t.timestamps
    end
  end
end
