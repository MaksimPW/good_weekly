class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :name
      t.text :description
      t.string :author
      t.text :comment
      t.integer :rating
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
