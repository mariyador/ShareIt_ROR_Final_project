class AddReservedByToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :reserved_by, :integer
    add_column :items, :reserved_by, :integer
  end
end
