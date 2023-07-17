class CreateLibraries < ActiveRecord::Migration[6.1]
  def change
    create_table :libraries do |t|
      t.string :library_name
      t.text :library_address
      t.references :user

      t.timestamps
    end
  end
end
