class CreateDogWalking < ActiveRecord::Migration[5.2]
  def change
    create_table :dog_walkings do |t|
      t.integer :status, default: 0
      t.timestamp :scheduled_at
      t.float :price
      t.integer :duration
      t.decimal :latitude
      t.decimal :longitude
      t.integer :pets_quantity
      t.timestamp :start_walk
      t.timestamp :finish_walk

      t.timestamps
    end
  end
end
