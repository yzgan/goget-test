class CreateDeliveryJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :delivery_jobs do |t|
      t.string :pickup_address
      t.string :pickup_latitude
      t.string :pickup_longitude
      t.string :dropoff_address
      t.string :dropoff_latitude
      t.string :dropoff_longitude
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
