class CreateItems < ActiveRecord::Migration[6.0] # Adjust the version accordingly
  def change
    create_table :items do |t|
      t.string :title
      t.text :body
      t.string :condition
      t.string :location
      t.decimal :price_per_day
      t.datetime :available_from
      t.datetime :available_until
      
      t.timestamps # This automatically adds created_at and updated_at
    end
  end
end