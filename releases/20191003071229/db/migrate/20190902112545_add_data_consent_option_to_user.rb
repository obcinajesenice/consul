class AddDataConsentOptionToUser < ActiveRecord::Migration
  def change
    add_column :users, :data_consent, :boolean, null: false, default: false
  end
end
