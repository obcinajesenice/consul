require_dependency Rails.root.join('app', 'controllers', 'admin', 'budget_headings_controller').to_s

class Admin::BudgetHeadingsController < Admin::BaseController
  include Translatable

  def budget_heading_params
    params.require(:budget_heading).permit(:name, :price, :population, :allow_custom_content,
                                           :latitude, :longitude, translation_params(Budget::Heading))
  end
end