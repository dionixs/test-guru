# frozen_string_literal: true

# == Schema Information
#
# Table name: tests
#
#  id          :integer          not null, primary key
#  level       :integer          default(0), not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  author_id   :integer          not null
#  category_id :integer          not null
#
# Indexes
#
#  index_tests_on_author_id    (author_id)
#  index_tests_on_category_id  (category_id)
#
# Foreign Keys
#
#  author_id    (author_id => users.id)
#  category_id  (category_id => categories.id)
#
class Test < ApplicationRecord

  # метод который возвращает отсортированный по убыванию массив
  # названий всех Тестов у которых Категория называется определённым образом
  # (название категории передается в метод в качестве аргумента).
  def self.test_names_by_category(title)
    joins('INNER JOIN categories ON tests.category_id = categories.id')
      .where(categories: { title: })
      .order(title: :desc)
      .pluck(:title)
  end
end
