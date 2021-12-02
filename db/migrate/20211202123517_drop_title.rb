class DropTitle < ActiveRecord::Migration[6.1]
  def change
    remove_reference :game_results, :title, index: true, foreign_key: true
    drop_table :titles do |t|
      t.string :name, null: false
      t.string :tweet_text
      t.timestamps
    end
  end
end
