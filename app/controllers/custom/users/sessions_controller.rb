class Users::SessionsController < Devise::SessionsController

  private

    def after_sign_out_path_for(resource)
      request.referer.present? && !request.referer.match("management") ? request.referer : super
    end

    def verifying_via_email?
      return false if resource.blank?
      stored_path = session[stored_location_key_for(resource)] || ""
      stored_path[0..5] == "/email"
    end

end
