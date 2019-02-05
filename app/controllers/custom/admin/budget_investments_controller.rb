require_dependency Rails.root.join('app', 'controllers', 'admin', 'budget_investments_controller').to_s

class Admin::BudgetInvestmentsController < Admin::BaseController

  private

  def budget_investment_params
    params.require(:budget_investment)
      .permit(:title, :description, :external_url, :heading_id, :administrator_id, :tag_list,
              :valuation_tag_list, :incompatible, :visible_to_valuators, :selected,
              valuator_ids: [], valuator_group_ids: [],
              documents_attributes: [:id, :title, :attachment, :cached_attachment, :user_id, :_destroy],
              image_attributes: [:id, :title, :attachment, :cached_attachment, :user_id, :_destroy],)
  end

end
