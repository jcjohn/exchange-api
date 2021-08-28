class ExchangeRatesController < ApplicationController
  def index
    @exchange_rate = ExchangeRate.find_by_code(params[:baseCode])
    if @exchange_rate.nil?
      new_rates = ExchangeRateApi.call(params[:baseCode])
      if new_rates&.rates.present?
        @exchange_rate = ExchangeRate.create(base_code: new_rates.base_code, rates: new_rates.rates)
      end
    end

    exchange_amount = (params[:baseAmount].to_d * @exchange_rate&.rates&.send(params[:exchangeCode].to_sym).to_d).round(2)

    render json: { exchangeAmount: exchange_amount }
  end
end