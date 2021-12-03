class AddLatestTopFlgToVideos < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :latest_top_flg, :boolean, default: false, null: false
  end
end
