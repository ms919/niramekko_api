class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.integer :type, null: false, default: 0
      t.integer :state, null: false, default: 0
      t.text :message, null: false
      t.timestamps
    end
  end
end
