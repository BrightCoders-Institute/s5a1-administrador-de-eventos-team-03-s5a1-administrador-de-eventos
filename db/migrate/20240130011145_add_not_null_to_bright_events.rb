class AddNotNullToBrightEvents < ActiveRecord::Migration[7.1]
  def change
    rename_column :bright_events, :tittle, :title
    rename_column :bright_events, :ubication, :location

    change_column_null :bright_events, :title, true
    change_column_null :bright_events, :description, true
    change_column_null :bright_events, :date, true
    change_column_null :bright_events, :location, true
    change_column_null :bright_events, :cost, true
  end
end
