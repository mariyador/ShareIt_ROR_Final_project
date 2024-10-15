class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :title
      t.text :body
      t.string :condition
      t.string :location
      t.decimal :price_per_day
      t.datetime :available_from
      t.datetime :available_until

      t.timestamps 
    end
  end
end
