class DeliveryJob < ApplicationRecord
  belongs_to :user

  validates :pickup_address, :pickup_latitude, :pickup_longitude, :dropoff_address, :dropoff_latitude,
            :dropoff_longitude, presence: true
end
