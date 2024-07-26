# frozen_string_literal: true

# == Schema Information
#
# Table name: user_tests
#
#  id         :integer          not null, primary key
#  progress   :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  test_id    :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_user_tests_on_test_id              (test_id)
#  index_user_tests_on_user_id              (user_id)
#  index_user_tests_on_user_id_and_test_id  (user_id,test_id) UNIQUE
#
# Foreign Keys
#
#  test_id  (test_id => tests.id)
#  user_id  (user_id => users.id)
#
class UserTest < ApplicationRecord
  belongs_to :user
  belongs_to :test
end
