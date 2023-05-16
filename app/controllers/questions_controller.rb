class QuestionsController < ApplicationController
  # before_action :set_question, only: %i[ create ]

  # POST /questions or /questions.json
  def create
    # Access the request parameters
    question = JSON.parse(request.body.read)["question"]

    answer = question
    # Process the request and prepare the response
    response = { message: answer }
    render json: response
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_question
    #   @question = Question.find(params[:id])
    # end

    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:question, :answer)
    end
end
