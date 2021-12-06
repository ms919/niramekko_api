class AddIndexDataVideoId < ActiveRecord::Migration[6.1]
  def change
    add_index :videos, :data_video_id, unique: true
  end
end
