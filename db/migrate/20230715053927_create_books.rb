class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :book_name
      t.string :book_author
      t.string :book_description
      t.integer :book_category
      t.integer :book_issued_to
      t.datetime :book_issued_date_start
      t.datetime :book_issued_date_end
      t.references :library

      t.timestamps
    end
  end
end
