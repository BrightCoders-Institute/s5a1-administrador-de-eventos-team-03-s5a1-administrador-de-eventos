class AddDateTime < ActiveRecord::Migration[7.1]
  def change
    add_column :bright_events, :reminder, :datetime
  end
end
