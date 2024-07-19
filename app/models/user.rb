# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string           not null
#  password   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord

  # метод принимает в качестве аргумента значение уровня сложности
  # и возвращает список всех Тестов, которые проходит
  # или когда-либо проходил Пользователь на этом уровне сложности
  def tests_by_level(level)
    Test.find_by_sql(['
      SELECT *
      FROM tests
      INNER JOIN user_tests ON user_tests.test_id = tests.id
      WHERE level = ? AND user_id = ?', level, self.id
    ])
  end
end
