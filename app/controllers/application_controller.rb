class ApplicationController < ActionController::Base
  protect_from_forgery

  # incluir explicitamente as helpers
  # => para que as suas funções sejam acessíveis também nos controllers
  # => por omissão os helpers só estariam acessíveis nos views
  include SessionsHelper
  include CartsHelper

end
