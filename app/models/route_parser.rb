require 'rails/application/route_inspector'

class RouteParser
  def initialize(route='', controller)
    @route = route
    @controller = controller
    parse
  end

  def parse
    route = @route
    Rails.application.reload_routes!
    Rails.application.routes.draw do
      eval(route) if route.present?
      root :to => 'application#parse'
    end

    @routes = inspector.format(Rails.application.routes.routes, @controller)
    @routes.pop
    self
  end

  def routes
    @routes.join("\n")
  end

  def grep(pattern)
    @routes = @routes.select { |route| route[/#{pattern}/] }
    self
  end

  def inspector
    @inspector ||= Rails::Application::RouteInspector.new
  end
end
