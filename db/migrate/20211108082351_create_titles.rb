class CreateTitles < ActiveRecord::Migration[6.1]
  def change
    create_table :titles do |t|
      t.string :name, null: false
      t.string :tweet_text
      t.timestamps
    end
  end
end
