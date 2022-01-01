class AddCannotPlayFlgToVideos < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :cannot_play_flg, :boolean, default: false, null: false
  end
end
