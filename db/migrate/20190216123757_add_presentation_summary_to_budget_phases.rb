class AddPresentationSummaryToBudgetPhases < ActiveRecord::Migration
  def change
    add_column :budget_phases, :presentation_summary_1, :text
    add_column :budget_phases, :presentation_summary_2, :text
    add_column :budget_phases, :presentation_summary_3, :text
  end
end
