require 'pdf-reader'
require 'openai'

PDF_FILE_PATH = "lib/frankenstein.pdf"

class BookPdfExtractor
  def self.call()
    reader = PDF::Reader.new(PDF_FILE_PATH)
    
    reader.pages.each do |page|
      book_data = BookDatum.new
      book_data.content = page.text
      book_data.embedding = generate_embedding(book_data.content)
  
      book_data.save
      book_data
    end
  end

  def self.generate_embedding(text)
    embedding = client.embeddings(
      parameters: { 
        model: "babbage-similarity", 
        input: text
      }
    )
    embedding['data'].first['embedding']
  end

  def self.client
    @client ||= OpenAI::Client.new
  end
end
