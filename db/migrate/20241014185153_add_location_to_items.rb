class AddLocationToItems < ActiveRecord::Migration[7.2]
  def change
    add_column :items, :city, :string
    add_column :items, :state, :string
    add_column :items, :zipcode, :string
  end
end
