class ApplicationController < ActionController::Base
  #protect_from_forgery

  def parse
    @route_parser = RouteParser.new(params[:route]).grep(params[:grep])
  end
end
