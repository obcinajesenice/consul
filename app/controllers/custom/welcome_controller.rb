class WelcomeController < ApplicationController
  include CustomPhasesHelper
  skip_authorization_check

  before_action :load_custom_phases, only: [:index]

  layout "devise", only: [:verification]

  def index
    @custom_phases = custom_phases
  end

  def verification
    redirect_to verification_path if signed_in?
  end
end
