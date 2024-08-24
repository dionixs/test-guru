module TestsHelper
  TEST_LEVELS = %i[easy elementary advanced hard].freeze

  def test_level(test)
    TEST_LEVELS[test.level] || :hero
  end

  def questions_count(test)
    test.questions.size
  end
end
