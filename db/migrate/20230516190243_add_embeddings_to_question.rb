class AddEmbeddingsToQuestion < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :embedding, :text
  end
end
