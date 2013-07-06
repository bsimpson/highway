class ApplicationController < ActionController::Base
  #protect_from_forgery

  def parse
    @route_parser = RouteParser.new(params[:route]).grep(params[:grep])

    respond_to do |format|
      format.text do
        if @route_parser.error.present?
          render inline: @route_parser.error, status: 400
        else
          render inline: @route_parser.routes, status: :ok
        end
      end
      format.html
    end
  end
end
