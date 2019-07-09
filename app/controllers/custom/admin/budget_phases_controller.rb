require_dependency Rails.root.join('app', 'controllers', 'admin', 'budget_phases_controller').to_s

class Admin::BudgetPhasesController < Admin::BaseController
  include Translatable

  def budget_phase_params
    valid_attributes = [:starts_at, :ends_at, :summary, :description, 
                        :enabled, :presentation_summary_1, :presentation_summary_2,
                        :presentation_summary_3, translation_params(Budget::Phase)]
    params.require(:budget_phase).permit(*valid_attributes)
  end

end
