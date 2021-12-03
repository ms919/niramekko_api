class AddTitleToGameResults < ActiveRecord::Migration[6.1]
  def change
    add_column :game_results, :title, :integer, null: false
    add_index :game_results, :title
  end
end
