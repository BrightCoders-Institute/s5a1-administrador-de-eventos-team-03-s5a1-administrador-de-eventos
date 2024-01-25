class CreateBrightEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :bright_events do |t|
      t.string :tittle
      t.string :description
      t.datetime :date
      t.string :ubication
      t.decimal :cost, precision: 6, scale: 2
      t.timestamps
    end
  end
end
