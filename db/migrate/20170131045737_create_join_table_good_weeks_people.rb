class CreateJoinTableGoodWeeksPeople < ActiveRecord::Migration[5.0]
  def change
    create_join_table :good_weeks, :people do |t|
      t.index [:person_id, :good_week_id]
      t.index [:good_week_id, :person_id]
    end
  end
end
