class CreateHiddenVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :hidden_videos do |t|
      t.references :user, foreign_key: true, null: false
      t.references :video, foreign_key: true, null: false
      t.timestamps
    end
  end
end
