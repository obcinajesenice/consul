class AddAnonymousOptionToBudgetInvestments < ActiveRecord::Migration
  def change
    add_column :budget_investments, :is_anonymous, :boolean, null: false, default: false
  end
end
