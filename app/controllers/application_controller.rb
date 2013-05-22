class ApplicationController < ActionController::Base
  #protect_from_forgery

  def parse
    @routes = RouteParser.new(params[:route], ENV['CONTROLLER']).grep(params[:grep]).routes
  end
end
