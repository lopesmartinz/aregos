class ApplicationController < ActionController::Base
  protect_from_forgery

  # incluir explicitamnete o "sessions_controller"
  # => para que as suas funções sejam acessíveis também nos controllers
  # => por omissão os helpers só estariam acessíveis nos views
  include SessionsHelper

end
