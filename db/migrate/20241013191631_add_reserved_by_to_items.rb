class AddReservedByToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :reserved_by, :integer
    add_index :items, :reserved_by
  end
end
