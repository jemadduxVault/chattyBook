require 'pdf-reader'
require 'openai'

PDF_FILE_PATH = "lib/frankenstein.pdf"

class BookPdfExtractor
  def self.call()
    reader = PDF::Reader.new(PDF_FILE_PATH)
    
    # reader.pages.each do |page|
      page = reader.pages.last
      book_data = BookDatum.new
      book_data.content = page.text
      book_data.embedding = generate_embedding(book_data.content)
  
      book_data.save
      book_data
    # end

  end

  def self.generate_embedding(text)
    puts "*********** TOP ***************"
    embedding = client.embeddings(
      parameters: { 
        model: "babbage-similarity", 
        input: text
      }
    )
    puts "----------------------"
    puts embedding
    puts "*********** BOTTOM ***************"
    embedding['embedding']
  end

  def self.client
  end
end
