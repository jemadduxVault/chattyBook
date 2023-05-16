class CreateBookData < ActiveRecord::Migration[7.0]
  def change
    create_table :book_data do |t|
      t.text :content
      t.text :embedding

      t.timestamps
    end
  end
end
