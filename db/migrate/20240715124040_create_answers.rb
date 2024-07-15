# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :answers do |t|
      t.string :value, null: false
      t.boolean :correct, default: false

      t.timestamps
    end
  end
end
