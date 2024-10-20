# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Category < ApplicationRecord
  default_scope -> { order(title: :asc) }

  has_many :tests, dependent: :delete_all

  validates :title, presence: true
end
