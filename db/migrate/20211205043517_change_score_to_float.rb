class ChangeScoreToFloat < ActiveRecord::Migration[6.1]
  def change
    change_column :laughed_videos, :score_diff, :float, null: false
    change_column :game_results, :score, :float, null: false
  end
end
