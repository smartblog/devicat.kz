class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: [:destroy, :update, :set_best]
  before_action :set_question, only: [:create]

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def update
    if current_user.author?(@answer)
      @answer.update(answer_params)
      @question = @answer.question
    else
      redirect_to question_path(@answer.question)
    end
  end

  def destroy
    if current_user.author?(@answer)
      @answer.destroy
    else
      redirect_to questions_path, notice: 'You do not have permission to destroy this answer'
    end
  end

  def set_best
    @answer.set_best if current_user.author?(@answer.question)
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end
end
