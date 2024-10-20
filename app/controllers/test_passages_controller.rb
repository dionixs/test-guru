class TestPassagesController < ApplicationController
  before_action :set_test_passage, only: %i[show update result]

  def show; end

  def result; end

  def update
    if params[:answer_ids]
      @test_passage.accept!(params[:answer_ids])
      path = @test_passage.completed? ? result_test_passage_path(@test_passage) : test_passage_path(@test_passage)
      redirect_to path
    else
      render :show
    end
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end
