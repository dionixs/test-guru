# frozen_string_literal: true

# == Schema Information
#
# Table name: tests
#
#  id          :bigint           not null, primary key
#  level       :integer          default(0), not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  author_id   :bigint           not null
#  category_id :bigint           not null
#
# Indexes
#
#  index_tests_on_author_id        (author_id)
#  index_tests_on_category_id      (category_id)
#  index_tests_on_title_and_level  (title,level) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#  fk_rails_...  (category_id => categories.id)
#
class Test < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :category

  has_many :questions, dependent: :delete_all
  has_many :user_tests, dependent: :delete_all
  has_many :users, through: :user_tests

  validates :title, presence: true,
            uniqueness: { scope: :level }

  validates :level, numericality: { only_integer: true },
            inclusion: { in: 0.. }

  scope :easy, -> { where(level: 0..1) }
  scope :medium, -> { where(level: 2..4) }
  scope :hard, -> { where(level: 5..Float::INFINITY) }

  scope :by_category_title, -> (title) { joins(:category)
                                           .where(categories: { title: })
                                           .order(title: :desc) }

  scope :by_level, -> (level) { where(level:) }

  # метод который возвращает отсортированный по убыванию массив
  # названий всех Тестов у которых Категория называется определённым образом
  # (название категории передается в метод в качестве аргумента).
  def self.test_titles_by_category(title)
    by_category_title(title).pluck(:title)
  end
end
