require_dependency Rails.root.join('app', 'controllers', 'management', 'budgets', 'investments_controller').to_s

class Management::Budgets::InvestmentsController < Management::BaseController

  private

  def investment_params
    params.require(:budget_investment).permit(:title, :description, :external_url, :heading_id,
                                              :tag_list, :organization_name, :location, :skip_map,
                                              map_location_attributes: [:latitude, :longitude, :zoom])
  end

end
