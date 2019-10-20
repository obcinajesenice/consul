require_dependency Rails.root.join('app', 'controllers', 'welcome_controller').to_s

class WelcomeController < ApplicationController
  include CustomPhasesHelper
  skip_authorization_check

  before_action :load_custom_phases, only: [:index]

  layout "devise", only: [:verification]

  def index
    @custom_phases = custom_phases
  end

end
