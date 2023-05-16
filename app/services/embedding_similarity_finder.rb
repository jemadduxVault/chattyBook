class EmbeddingSimilarityFinder
  def self.call(question)
    # Calculate cosine similarity for each embedding
    similarities = all_book_embeddings.map do |embedding|
      [embedding[0], cosine_similarity(question.embedding, embedding[1])]
    end

    # Sort the similarities and take the top 5
    top_5_similarities = similarities.sort_by{|a| a[1]}.last(5)
    ids = top_5_similarities.map{|s| s[0]}
    BookDatum.where(id: ids)
  end

  def self.all_book_embeddings
    @all_embeddings ||= BookDatum.all.pluck(:id, :embedding)
  end

  def self.cosine_similarity(embedding1, embedding2)
    dot_product = 0.0
    norm1 = 0.0
    norm2 = 0.0
  
    embedding1.each_with_index do |value1, i|
      value2 = embedding2[i]
      dot_product += value1 * value2
      norm1 += value1 * value1
      norm2 += value2 * value2
    end
  
    similarity = dot_product / (Math.sqrt(norm1) * Math.sqrt(norm2))
    similarity
  end
end
