class ChangeNotNullToLatestTopRecord < ActiveRecord::Migration[6.1]
  def change
    change_column_null :latest_top_records, :user_id, true
  end
end
