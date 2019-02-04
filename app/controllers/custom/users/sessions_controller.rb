require_dependency Rails.root.join('app', 'controllers', 'users', 'sessions_controller').to_s

class Users::SessionsController < Devise::SessionsController

  private

  def after_sign_in_path_for(resource)
    super
  end

end
