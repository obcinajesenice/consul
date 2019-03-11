class AddStatusToBudgetInvestment < ActiveRecord::Migration
  def change
    add_column :budget_investments, :status, :string
  end
end
