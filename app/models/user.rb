# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  password   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  has_many :created_tests, class_name: 'Test', foreign_key: 'author_id',
           dependent: :delete_all
  has_many :user_tests, dependent: :delete_all
  has_many :tests, through: :user_tests, dependent: :delete_all

  # метод принимает в качестве аргумента значение уровня сложности
  # и возвращает список всех Тестов, которые проходит
  # или когда-либо проходил Пользователь на этом уровне сложности
  def tests_by_level(level)
    Test.joins('INNER JOIN user_tests ON user_tests.test_id = tests.id')
        .where(level:, user_tests: { user_id: id })
  end
end
