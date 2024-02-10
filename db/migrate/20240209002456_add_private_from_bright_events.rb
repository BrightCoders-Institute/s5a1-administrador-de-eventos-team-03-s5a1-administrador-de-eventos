class AddPrivateFromBrightEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :bright_events, :privacy, :boolean
  end
end
