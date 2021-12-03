class ChangeTitleIdToTitle < ActiveRecord::Migration[6.1]
  def change
    rename_column :game_results, :title_id, :title
  end
end
