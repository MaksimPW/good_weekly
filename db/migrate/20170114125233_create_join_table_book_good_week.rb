class CreateJoinTableBookGoodWeek < ActiveRecord::Migration[5.0]
  def change
    create_join_table :books, :good_weeks do |t|
      t.index [:book_id, :good_week_id]
      t.index [:good_week_id, :book_id]
    end
  end
end
