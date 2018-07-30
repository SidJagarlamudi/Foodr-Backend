class CreateBusinesses < ActiveRecord::Migration[5.2]
  def change
    create_table :businesses do |t|
      t.string :business_id
      t.string :name
      t.string :image_url
      t.boolean :is_closed
      t.string :url
      t.integer :reviews
      t.float :rating
      t.boolean :do_delivery
      t.string :price
      t.string :address
      t.string :phone
      t.string :categories
      t.float :latitude
      t.float :longitude
      t.integer :search_id

      t.timestamps
    end
  end
end
