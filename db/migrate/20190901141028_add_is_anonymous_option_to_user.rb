class AddIsAnonymousOptionToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_anonymous, :boolean, null: false, default: false
  end
end
