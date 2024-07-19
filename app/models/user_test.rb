# frozen_string_literal: true

# == Schema Information
#
# Table name: user_tests
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  test_id    :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_user_tests_on_test_id  (test_id)
#  index_user_tests_on_user_id  (user_id)
#
# Foreign Keys
#
#  test_id  (test_id => tests.id)
#  user_id  (user_id => users.id)
#
class UserTest < ApplicationRecord
end
