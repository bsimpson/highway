require 'test_helper'

class ExampleTest < ActiveSupport::TestCase
  test 'generate slug on validation' do
    example = Example.new
    assert_nil example.slug
    example.valid?
    assert example.slug
  end

  test 'slug is not regenerated' do
    example = Example.new
    example.valid?
    expected = example.slug
    example.valid?
    assert_equal expected, example.slug
  end
end
