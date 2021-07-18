class AddLockVersionToDeliveryJobs < ActiveRecord::Migration[6.1]
  def change
    add_column :delivery_jobs, :lock_version, :integer
  end
end
