class AddImageToItems < ActiveRecord::Migration[7.2]
  def change
    add_column :items, :image, :string
  end
end
