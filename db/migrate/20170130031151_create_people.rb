class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.string :fio
      t.date :birthday
      t.text :description
      t.text :note
      t.references :user, foreign_key: true

      t.timestamps

    end
  end
end
