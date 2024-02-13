class AddReferenceUserToEvent < ActiveRecord::Migration[7.1]
  def change
    add_reference :bright_events, :user, null: false, foreign_key: true
  end
end
