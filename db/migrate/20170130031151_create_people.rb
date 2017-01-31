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

    add_index :good_weeks_people, [:person_id, :good_week_id]
    add_index :good_weeks_people, [:good_week_id, :person_id]
  end
end
