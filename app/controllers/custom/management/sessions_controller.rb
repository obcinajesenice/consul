require_dependency Rails.root.join('app', 'controllers', 'management', 'sessions_controller').to_s

class Management::SessionsController < ActionController::Base
  def create
    destroy_session
    if admin? || manager? || authenticated_manager?
      redirect_to management_root_path
    else
      redirect_to new_user_session_path
      # raise CanCan::AccessDenied
    end
  end
end
