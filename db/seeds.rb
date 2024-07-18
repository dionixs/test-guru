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
    { title: "Backend" },
    { title: "Frontend" },
    { title: "History" },
    { title: "Philosophy" },
    { title: "Linguistics" },
    { title: "Music" }
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
  tests = [
    { title: "Ruby Beginner", level: 0, category_id: Category.first.id, author_id: User.first.id },
    { title: "Ruby Advanced", level: 1, category_id: Category.first.id, author_id: User.first.id },
    { title: "Haskell", level: 2, category_id: Category.first.id, author_id: User.first.id },
    { title: "Java Script", level: 1, category_id: Category.second.id, author_id: User.last.id },
    { title: "HTML", level: 1, category_id: Category.second.id, author_id: User.last.id },
    { title: "CSS", level: 1, category_id: Category.second.id, author_id: User.last.id }
  ]

  tests.each do |test|
    Test.find_or_create_by!(test)
  end
end

Question.transaction do
  questions = [
    { value: "What is the output of 1 + 1 in Ruby?", test_id: Test.find_by(title: "Ruby Beginner").id },
    { value: "How do you define a method in Ruby?", test_id: Test.find_by(title: "Ruby Beginner").id },
    { value: "What is a block in Ruby?", test_id: Test.find_by(title: "Ruby Beginner").id },
    { value: "How do you create a class in Ruby?", test_id: Test.find_by(title: "Ruby Advanced").id },
    { value: "What is a module in Ruby?", test_id: Test.find_by(title: "Ruby Advanced").id },
    { value: "Explain the difference between a proc and a lambda in Ruby.", test_id: Test.find_by(title: "Ruby Advanced").id }
  ]

  questions.each do |question|
    Question.find_or_create_by!(question)
  end
end

Answer.transaction do
  answers = [
    # Ruby Beginner
    { value: "2", correct: true, question_id: Question.find_by(value: "What is the output of 1 + 1 in Ruby?").id },
    { value: "3", correct: false, question_id: Question.find_by(value: "What is the output of 1 + 1 in Ruby?").id },
    { value: "11", correct: false, question_id: Question.find_by(value: "What is the output of 1 + 1 in Ruby?").id },
    { value: "1", correct: false, question_id: Question.find_by(value: "What is the output of 1 + 1 in Ruby?").id },

    { value: "def method_name; end", correct: true, question_id: Question.find_by(value: "How do you define a method in Ruby?").id },
    { value: "function method_name; end", correct: false, question_id: Question.find_by(value: "How do you define a method in Ruby?").id },
    { value: "method_name() { }", correct: false, question_id: Question.find_by(value: "How do you define a method in Ruby?").id },
    { value: "function method_name() { }", correct: false, question_id: Question.find_by(value: "How do you define a method in Ruby?").id },

    { value: "A block is a chunk of code enclosed between do and end or {}.", correct: true, question_id: Question.find_by(value: "What is a block in Ruby?").id },
    { value: "A block is an object in Ruby.", correct: false, question_id: Question.find_by(value: "What is a block in Ruby?").id },
    { value: "A block is a method in Ruby.", correct: false, question_id: Question.find_by(value: "What is a block in Ruby?").id },
    { value: "A block is a class in Ruby.", correct: false, question_id: Question.find_by(value: "What is a block in Ruby?").id },

    # Ruby Advanced
    { value: "class ClassName; end", correct: true, question_id: Question.find_by(value: "How do you create a class in Ruby?").id },
    { value: "def ClassName; end", correct: false, question_id: Question.find_by(value: "How do you create a class in Ruby?").id },
    { value: "create_class ClassName", correct: false, question_id: Question.find_by(value: "How do you create a class in Ruby?").id },
    { value: "class ClassName() { }", correct: false, question_id: Question.find_by(value: "How do you create a class in Ruby?").id },

    { value: "A module is a collection of methods and constants.", correct: true, question_id: Question.find_by(value: "What is a module in Ruby?").id },
    { value: "A module is a class in Ruby.", correct: false, question_id: Question.find_by(value: "What is a module in Ruby?").id },
    { value: "A module is an object in Ruby.", correct: false, question_id: Question.find_by(value: "What is a module in Ruby?").id },
    { value: "A module is a block in Ruby.", correct: false, question_id: Question.find_by(value: "What is a module in Ruby?").id },

    { value: "Procs are objects, lambdas are not.", correct: false, question_id: Question.find_by(value: "Explain the difference between a proc and a lambda in Ruby.").id },
    { value: "Lambdas check the number of arguments, procs do not.", correct: true, question_id: Question.find_by(value: "Explain the difference between a proc and a lambda in Ruby.").id },
    { value: "Procs are anonymous functions, lambdas are not.", correct: false, question_id: Question.find_by(value: "Explain the difference between a proc and a lambda in Ruby.").id },
    { value: "Lambdas cannot return values, procs can.", correct: false, question_id: Question.find_by(value: "Explain the difference between a proc and a lambda in Ruby.").id }
  ]

  answers.each do |answer|
    Answer.find_or_create_by!(answer)
  end
end
