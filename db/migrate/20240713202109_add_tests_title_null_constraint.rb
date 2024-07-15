# frozen_string_literal: true

class AddTestsTitleNullConstraint < ActiveRecord::Migration[7.1]
  def change
    change_column_null :tests, :title, false
  end
end
