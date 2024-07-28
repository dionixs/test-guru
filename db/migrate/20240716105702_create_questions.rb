# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.string :value, null: false

      t.references :test, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
