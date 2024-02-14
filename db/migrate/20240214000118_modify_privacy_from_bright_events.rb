class ModifyPrivacyFromBrightEvents < ActiveRecord::Migration[7.1]
  def change
    change_column_default :bright_events, :privacy, from: false, to: true
  end
end
