class CreateFurnitures < ActiveRecord::Migration[7.0]
  def change
    create_table :furnitures do |t|
      t.references :user, null: false, foreign_key: true
      t.string :image
      t.text :description
      t.integer :price
      t.integer :warranty

      t.timestamps
    end
  end
end
