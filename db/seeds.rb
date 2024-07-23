# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


Category.transaction do
  categories = [
    { title: 'Backend' },
    { title: 'Frontend' },
    { title: 'History' },
    { title: 'Philosophy' },
    { title: 'Linguistics' },
    { title: 'Music' }
  ]

  categories.each do |category|
    Category.find_or_create_by!(category)
  end
end

User.transaction do
  10.times do
    User.find_or_create_by!(
      email: Faker::Internet.email,
      password: Faker::Internet.password
    )
  end
end

Test.transaction do
  first_category = Category.find_by_title('Backend').id
  second_category = Category.find_by_title('Frontend').id

  first_author = User.first.id
  last_author = User.last.id

  tests = [
    { title: 'Ruby Beginner', level: 0, category_id: first_category, author_id: first_author },
    { title: 'Ruby Advanced', level: 1, category_id: first_category, author_id: first_author },
    { title: 'Haskell', level: 2, category_id: first_category, author_id: first_author },
    { title: 'Java Script', level: 1, category_id: second_category, author_id: last_author },
    { title: 'HTML', level: 1, category_id: second_category, author_id: last_author },
    { title: 'CSS', level: 1, category_id: second_category, author_id: last_author }
  ]

  tests.each do |test|
    Test.find_or_create_by!(test)
  end
end

Question.transaction do
  ruby_beginner = Test.find_by(title: 'Ruby Beginner').id
  ruby_advanced = Test.find_by(title: 'Ruby Advanced').id

  questions = [
    { value: 'What is the output of 1 + 1 in Ruby?', test_id: ruby_beginner  },
    { value: 'How do you define a method in Ruby?', test_id: ruby_beginner },
    { value: 'What is a block in Ruby?', test_id: ruby_beginner },
    { value: 'How do you create a class in Ruby?', test_id: ruby_advanced },
    { value: 'What is a module in Ruby?', test_id: ruby_advanced },
    { value: 'Explain the difference between a proc and a lambda in Ruby.', test_id: ruby_advanced }
  ]

  questions.each do |question|
    Question.find_or_create_by!(question)
  end
end

Answer.transaction do
  question_1 = Question.find_by(value: 'What is the output of 1 + 1 in Ruby?').id
  question_2 = Question.find_by(value: 'How do you define a method in Ruby?').id
  question_3 = Question.find_by(value: 'What is a block in Ruby?').id
  question_4 = Question.find_by(value: 'How do you create a class in Ruby?').id
  question_5 = Question.find_by(value: 'What is a module in Ruby?').id
  question_6 = Question.find_by(value: 'Explain the difference between a proc and a lambda in Ruby.').id

  answers = [
    # Ruby Beginner
    { value: '2', correct: true, question_id: question_1 },
    { value: '3', correct: false, question_id: question_1 },
    { value: '11', correct: false, question_id: question_1 },
    { value: '1', correct: false, question_id: question_1 },

    { value: 'def method_name; end', correct: true, question_id: question_2 },
    { value: 'function method_name; end', correct: false, question_id: question_2 },
    { value: 'method_name() { }', correct: false, question_id: question_2 },
    { value: 'function method_name() { }', correct: false, question_id: question_2 },

    { value: 'A block is a chunk of code enclosed between do and end or {}.', correct: true, question_id: question_3 },
    { value: 'A block is an object in Ruby.', correct: false, question_id: question_3 },
    { value: 'A block is a method in Ruby.', correct: false, question_id: question_3 },
    { value: 'A block is a class in Ruby.', correct: false, question_id: question_3 },

    # Ruby Advanced
    { value: 'class ClassName; end', correct: true, question_id: question_4 },
    { value: 'def ClassName; end', correct: false, question_id: question_4 },
    { value: 'create_class ClassName', correct: false, question_id: question_4 },
    { value: 'class ClassName() { }', correct: false, question_id: question_4 },

    { value: 'A module is a collection of methods and constants.', correct: true, question_id: question_5 },
    { value: 'A module is a class in Ruby.', correct: false, question_id: question_5 },
    { value: 'A module is an object in Ruby.', correct: false, question_id: question_5 },
    { value: 'A module is a block in Ruby.', correct: false, question_id: question_5 },

    { value: 'Procs are objects, lambdas are not.', correct: false, question_id: question_6 },
    { value: 'Lambdas check the number of arguments, procs do not.', correct: true, question_id: question_6 },
    { value: 'Procs are anonymous functions, lambdas are not.', correct: false, question_id: question_6 },
    { value: 'Lambdas cannot return values, procs can.', correct: false, question_id: question_6 }
  ]

  answers.each do |answer|
    Answer.find_or_create_by!(answer)
  end
end

UserTest.transaction do
  user = User.first.id
  test_1 = Test.find_by_title('Ruby Beginner').id
  test_2 = Test.find_by_title('CSS').id

  UserTest.find_or_create_by!(user_id: user, test_id: test_2)
  UserTest.find_or_create_by!(user_id: user, test_id: test_1)
end
