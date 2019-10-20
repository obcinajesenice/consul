require_dependency Rails.root.join('app', 'controllers', 'valuation', 'budget_investments_controller').to_s

class Valuation::BudgetInvestmentsController < Valuation::BaseController

  def valuate
    if valid_price_params? && @investment.update(valuation_params)

      # if @investment.unfeasible_email_pending?
      #   @investment.send_unfeasible_email
      # end

      Activity.log(current_user, :valuate, @investment)
      notice = t('valuation.budget_investments.notice.valuate')
      redirect_to valuation_budget_budget_investment_path(@budget, @investment), notice: notice
    else
      render action: :edit
    end
  end

  def heading_filters
    investments = @budget.investments.by_valuator(current_user.valuator.try(:id))
                                     .visible_to_valuators.distinct

    investment_headings = Budget::Heading.where(id: investments.pluck(:heading_id).uniq)
                                         .order(id: :asc)

    all_headings_filter = [
                            {
                              name: t('valuation.budget_investments.index.headings_filter_all'),
                              id: nil,
                              count: investments.size
                            }
                          ]
    filters = investment_headings.inject(all_headings_filter) do |filters, heading|
                filters << {
                             name: heading.name,
                             id: heading.id,
                             count: investments.select{|i| i.heading_id == heading.id}.size
                           }
              end
  end

end
