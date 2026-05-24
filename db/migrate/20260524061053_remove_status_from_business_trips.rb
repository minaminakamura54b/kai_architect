class RemoveStatusFromBusinessTrips < ActiveRecord::Migration[7.0]
  def change
    remove_column :business_trips, :status, :integer
  end
end
