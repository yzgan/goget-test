class AddClaimantIdToDeliveryJob < ActiveRecord::Migration[6.1]
  def change
    add_reference :delivery_jobs, :claimant, foreign_key: { to_table: :users }
  end
end
