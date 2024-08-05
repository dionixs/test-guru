class QuestionsController < ApplicationController
  before_action :find_test, only: %i[index new create]
  before_action :find_question, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    @questions = @test.questions
  end

  def show; end

  def new
    @question = @test.questions.build
  end

  def edit
    @test = @question.test
  end

  def create
    @question = @test.questions.build(question_params)

    if @question.save
      # status: 303
      redirect_to test_questions_path(@test), status: :see_other
    else
      # status: 422
      render :new, status: :unprocessable_content
    end
  end

  def update
    @test = @question.test
    if @question.update(question_params)
      redirect_to test_questions_path(@test), status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @question.destroy
    redirect_to test_questions_path(@question.test)
  end

  private

  def question_params
    params.require(:question).permit(:value)
  end

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def rescue_with_question_not_found
    render plain: 'Question was not found'
  end
end
