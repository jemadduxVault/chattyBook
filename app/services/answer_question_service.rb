require 'openai'

class AnswerQuestionService
  def self.call(question)
    most_similar_book_data = EmbeddingSimilarityFinder.call(question)
    content = most_similar_book_data.pluck(:content).join(" ").gsub("\n", " ")

    prompt = "Given this book content: #{content}. \n Answer this question in a complete sentence ending with correct puncuation: #{question.question}"

    completion = OpenAI::Client.new.completions(
      parameters: {
        model: 'babbage-similarity',
        prompt: prompt
      }
    )
    question.answer = completion.dig("choices", 0, "text").strip
    question.save!
  end

  def self.client
    @client ||= OpenAI::Client.new
  end
end
