Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :api do
    scope :v1 do
      resources :markets, only: [:index] do
        collection do
          get "prices/:market_name", action: "prices"
        end
      end
    end
  end
end
