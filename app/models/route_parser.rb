require 'rails/application/route_inspector'
require 'dummy'

class RouteParser
  attr_reader :error

  def initialize(route='', controller=nil)
    @route = route
    @controller = controller
    parse
  end

  def parse
    route = @route
    begin
      Dummy.routes.draw do
        eval(route) if route.present?
      end
      @routes = inspector.format(Dummy.routes.routes, @controller)
    rescue SyntaxError, Exception => e
      @error = e.message
      @routes = []
    end
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
