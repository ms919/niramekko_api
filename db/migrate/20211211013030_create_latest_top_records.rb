class CreateLatestTopRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :latest_top_records do |t|
      t.references :user, foreign_key: true, null: false
      t.references :video, foreign_key: true, null: false
      t.float :avg_score, null: false
      t.timestamps
    end
  end
end
