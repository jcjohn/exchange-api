class ExchangeRatesController < ApplicationController
  def index
    @exchange_rate = ExchangeRate.find_by_code(params[:base_code])
    if @exchange_rate.nil?
      new_rates = ExchangeRateApi.call(params[:base_code])
      if new_rates.rates.present?
        @exchange_rate = ExchangeRate.create(base_code: new_rates.base_code, rates: new_rates.rates)
      end
    end

    exchange_amount = (params[:amount].to_d * @exchange_rate.rates.send(params[:exchange_code].to_sym).to_d).round(2)

    render json: { exchange_amount: exchange_amount }
  end
end