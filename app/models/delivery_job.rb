class DeliveryJob < ApplicationRecord
  belongs_to :user
  belongs_to :claimant, class_name: 'User', optional: true

  validates :pickup_address, :pickup_latitude, :pickup_longitude, :dropoff_address, :dropoff_latitude,
            :dropoff_longitude, presence: true

  enum status: { pending: 0, executed: 1 }
end
