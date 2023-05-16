class QuestionsController < ApplicationController
  # POST /questions or /questions.json
  def create
    # Access the request parameters
    user_question = JSON.parse(request.body.read)["question"]
    @question = Question.create(question: user_question)
    @question.generate_embedding

    answer = user_question
    # Process the request and prepare the response
    response = { message: answer }
    render json: response
  end

  private
    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:question, :answer)
    end
end
