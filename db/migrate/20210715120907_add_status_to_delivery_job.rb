class AddStatusToDeliveryJob < ActiveRecord::Migration[6.1]
  def change
    add_column :delivery_jobs, :status, :integer, default: 0, null: false
  end
end
