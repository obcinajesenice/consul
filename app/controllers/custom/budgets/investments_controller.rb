require_dependency Rails.root.join('app', 'controllers', 'budgets', 'investments_controller').to_s

module Budgets
  class InvestmentsController < ApplicationController
    include CustomPhasesHelper

    before_action :load_custom_phases, only: [:index]

    has_orders %w{most_voted newest}, only: :show
    has_orders ->(c) { c.investments_orders }, only: :index

    def index
      if @budget.finished?
        @investments = investments.winners.page(params[:page]).per(21).for_render
      else
        @investments = investments.page(params[:page]).per(21).for_render
      end

      @investment_ids = @investments.pluck(:id)
      load_investment_votes(@investments)
      @tag_cloud = tag_cloud
    end

    def investments_orders
      case current_budget.phase
      when 'accepting', 'reviewing'
        %w{created_at}
      when 'publishing_prices', 'balloting', 'reviewing_ballots'
        %w{created_at price}
      when 'finished'
        %w{created_at}
      else
        %w{created_at confidence_score}
      end
    end

  end

end
