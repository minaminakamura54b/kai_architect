class CreateBusinessTrips < ActiveRecord::Migration[7.0]
  def change
    create_table :business_trips do |t|
      t.references :user, null: false, foreign_key: true
      t.references :site, null: false, foreign_key: true
      t.date :started_at
      t.date :ended_at
      t.string :destination
      t.text :purpose
      t.text :report
      t.decimal :expenses

      t.timestamps
    end
  end
end
