require 'rails/application/route_inspector'
require 'timeout'
require 'dummy'

class RouteParser
  attr_reader :error, :route, :pattern

  def initialize(route='', controller=nil)
    @route = route
    @controller = controller
    parse
  end

  def parse
    route = @route
    begin
      Timeout::timeout(1) do
        Dummy.routes.draw do
          instance_eval(-> { $SAFE=4; route }.call) if route.present?
        end
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
    @pattern = pattern
    @routes = @routes.select { |route| route[/#{pattern}/] }
    self
  end

  def inspector
    @inspector ||= Rails::Application::RouteInspector.new
  end
end
