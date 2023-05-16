class QuestionsController < ApplicationController
  # POST /questions or /questions.json
  def create
    # Access the request parameters
    user_question = JSON.parse(request.body.read)["question"]
    @question = Question.create(question: user_question)
    @question.generate_embedding

    answer = AnswerQuestionService.call(@question)
    render json: { message: answer }
  end

  private
    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:question, :answer)
    end
end
