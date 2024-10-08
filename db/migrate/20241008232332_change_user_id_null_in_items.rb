class ChangeUserIdNullInItems < ActiveRecord::Migration[6.0]
  def change
    change_column_null :items, :user_id, false
  end
end
