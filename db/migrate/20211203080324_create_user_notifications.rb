class CreateUserNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :user_notifications do |t|
      t.references :user, foreign_key: true, null: false
      t.string :message
      t.boolean :read_flg, default: false, null: false
      t.timestamps
    end
  end
end
