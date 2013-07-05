class ApplicationController < ActionController::Base
  #protect_from_forgery

  def parse
    @route_parser = RouteParser.new(params[:route]).grep(params[:grep])

    respond_to do |format|
      format.text do
        render inline: @route_parser.routes
      end
      format.html
    end
  end
end
