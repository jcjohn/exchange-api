class ExchangeRateApi
  require 'net/http'
  
  ServerError = Class.new(StandardError)
  NonJsonResponse = Class.new(StandardError)
  
  attr_accessor :base_code, :rates

  def self.call(base_currency)
    uri = URI("https://open.er-api.com/v6/latest/#{base_currency}")
    response = Net::HTTP.get_response(uri)

    if response.code == '200'
      new(JSON.parse(response.body))
    elsif response.code.to_i > 500
      raise ServerError, 'There was an error communicating with the API'
    end
  rescue JSON::ParseError => e
    raise NonJsonResponse.new(e)
  end

  def initialize(attributes = {})
    attributes.each do |key, value|
      send("#{key}=".to_sym, value) if self.respond_to?("#{key}=".to_sym)
    end
  end
end
