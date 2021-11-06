class CreateVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :videos do |t|
      t.references :user, foreign_key: true
      t.string :video_user, null: false
      t.string :data_video_id, null: false
      t.timestamps
    end
  end
end
