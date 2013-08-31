class ExamplesController < ApplicationController
  def show
    example = Example.find_by_slug!(params[:id])
    route_parser = RouteParser.new(example.route).grep(example.grep)
    render template: 'application/parse', locals: { route_parser: route_parser }
  end

  def create
    example = Example.create!(params[:example])
    redirect_to example_path(example.slug)
  end
end
