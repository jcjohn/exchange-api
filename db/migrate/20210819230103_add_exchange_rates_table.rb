class AddExchangeRatesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :exchange_rates do |t|
      t.string :base_code, index: true
      t.jsonb :rates
    
      t.timestamps
    end
    
  end
end
