# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :answers do |t|
      t.string :value, null: false
      t.boolean :correct, null: false, default: false

      t.references :question, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
