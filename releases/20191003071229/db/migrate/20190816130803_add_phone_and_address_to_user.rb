class AddPhoneAndAddressToUser < ActiveRecord::Migration
  def change
    add_column :users, :phone, :text
    add_column :users, :address, :text
  end
end
