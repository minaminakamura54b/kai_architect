class CreateInspections < ActiveRecord::Migration[7.0]
  def change
    create_table :inspections do |t|
      t.references :site, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :inspected_at
      t.integer :status
      t.text :result
      t.text :remarks

      t.timestamps
    end
  end
end
