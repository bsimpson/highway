require 'test_helper'

class ExamplesControllerTest < ActionController::TestCase
  test 'create makes an example record' do
    post :create, example: { route: 'route', grep: 'grep' }

    expected = Example.last
    assert_equal 'route', expected.route
    assert_equal 'grep', expected.grep
  end

  test 'show example' do
    example = Example.create(route: 'foo')
    get :show, id: example.slug
    assert_equal example.route, assigns(:route_parser).route
    assert_template 'application/parse'
  end
end
