class CreateGoodWeeks < ActiveRecord::Migration[5.0]
  def change
    create_table :good_weeks do |t|
      t.date :monday, null: false
      t.text :note

      t.timestamps
    end
  end
end
