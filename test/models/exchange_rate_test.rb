require 'test_helper'

class ExchangeRateTest < ActiveSupport::TestCase
  test 'rate is an OpenStruct' do
    rate = ExchangeRate.new(base_code: 'baz', rates: { foo: 'bar' })
    assert_equal true, rate.rates.is_a?(OpenStruct)
  end
end