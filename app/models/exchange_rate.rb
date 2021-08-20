class ExchangeRate < ApplicationRecord
  def self.find_by_code(code)
    find_by(base_code: code)
  end

  def rates
    OpenStruct.new(self[:rates])
  end
end