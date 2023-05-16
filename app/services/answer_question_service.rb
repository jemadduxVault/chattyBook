require 'openai'

class AnswerQuestionService
  def self.call(question)
    content = BookDatum.last(5).pluck(:content)
    prompt = "Answer this question: #{question.question}\n About this content: #{content.join("\n")}"

    completion = OpenAI::Client.new.completions(
      parameters: {
        model: 'text-davinci-003',
        prompt: prompt
      }
    )
    answer = completion.dig("choices", 0, "text").strip

    answer
  end

  def self.client
    @client ||= OpenAI::Client.new
  end
end
