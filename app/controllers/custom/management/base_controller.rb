require_dependency Rails.root.join('app', 'controllers', 'management', 'base_controller').to_s

class Management::BaseController < ActionController::Base
  private
    def verify_manager
      if current_manager.blank?
        redirect_to management_sign_in_url
      end
      # raise ActionController::RoutingError.new('Not Found') if current_manager.blank?
    end
end
