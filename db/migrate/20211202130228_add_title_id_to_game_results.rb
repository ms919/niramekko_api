class AddTitleIdToGameResults < ActiveRecord::Migration[6.1]
  def change
    add_column :game_results, :title_id, :integer, null: false
    add_index :game_results, :title_id
  end
end
