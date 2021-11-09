class CreateGameResults < ActiveRecord::Migration[6.1]
  def change
    create_table :game_results do |t|
      t.references :user, foreign_key: true
      t.references :title, foreign_key: true, null: false
      t.integer :mode, null: false
      t.integer :score, null: false
      t.timestamps
    end
  end
end
