class QuestionsController < ApplicationController
  # POST /questions or /questions.json
  def create
    # Access the request parameters
    user_question = JSON.parse(request.body.read)["question"]
    @question = Question.find_or_create_by(question: user_question)
    unless @question.answer && @question.embedding
      @question.generate_embedding
      AnswerQuestionService.call(@question)
    end
    render json: { message: @question.reload.answer }
  end

  private
    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:question, :answer)
    end
end
