require 'test_helper'

class ExchangeRateApiMock
  attr_accessor :base_code, :rates
  def self.call(base_code)
    new(
      base_code: 'USD',
      rates: {
        'CAD': 1.44
      }
    )
  end

  def initialize(attributes)
    attributes.each { |key, value| send("#{key}=".to_sym, value) if self.respond_to?("#{key}=".to_sym)}
  end
end

class ExchangeRateMock
  attr_accessor :base_code, :rates
  def self.find_by_code(base_code)
    new(
      base_code: 'USD',
      rates: {
        'CAD': 1.42
      }
    )
  end

  def initialize(attributes)
    attributes.each { |key, value| send("#{key}=".to_sym, value) if self.respond_to?("#{key}=".to_sym)}
  end

  def rates
    OpenStruct.new(@rates)
  end
end

class ExchangeRatesControllerTest < ActionDispatch::IntegrationTest
  test 'returns the database value' do
    class ::ExchangeRate
      def self.find_by_code(base_code)
        ExchangeRateMock.find_by_code(base_code)
      end
    end

    get '/exchange_rates', params: { baseCode: 'USD', exchangeCode: 'CAD', baseAmount: 2 }
    json = JSON.parse(response.body)

    assert_equal true, json.key?('exchangeAmount')
    assert_equal 2.84.to_d, json['exchangeAmount'].to_d
  end

  test 'returns the value from the API' do
    class ::ExchangeRateApi
      def self.call(base_code)
        ExchangeRateApiMock.call(base_code)
      end
    end

    get '/exchange_rates', params: { baseCode: 'USD', exchangeCode: 'CAD', baseAmount: 2 }
    json = JSON.parse(response.body)

    assert_equal true, json.key?('exchangeAmount')
    assert_equal 2.88.to_d, json['exchangeAmount'].to_d
  end
end