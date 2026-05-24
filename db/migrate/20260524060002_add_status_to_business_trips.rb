class AddStatusToBusinessTrips < ActiveRecord::Migration[7.0]
  def change
    add_column :business_trips, :status, :integer, default: 0, null: false
  end
end
