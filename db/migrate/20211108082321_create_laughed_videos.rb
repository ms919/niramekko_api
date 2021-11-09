class CreateLaughedVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :laughed_videos do |t|
      t.references :user, foreign_key: true
      t.references :video, foreign_key: true, null: false
      t.integer :score_diff, null: false
      t.timestamps
    end
  end
end
