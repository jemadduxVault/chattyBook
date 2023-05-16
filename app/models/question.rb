class Question < ApplicationRecord
  serialize :embedding, Array

  def generate_embedding()
    client = OpenAI::Client.new
    open_ai_embedding = client.embeddings(
      parameters: {
        model: "babbage-similarity",
        input: question
      }
    )
    self.embedding = open_ai_embedding['data'].first['embedding']
    self.save!
  end
end
