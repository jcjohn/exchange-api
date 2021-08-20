Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :exchange_rates, only: :index

  root 'exchange_rates#index'
end
