class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :uid, null: false
      t.string :provider, null: false
      t.string :name
      t.string :image_url
      t.integer :role, default: 0
      t.timestamps
    end
    add_index :users, [:uid, :provider], unique: true
  end
end
