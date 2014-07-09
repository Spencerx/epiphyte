Rails.application.routes.draw do

  namespace :api do
    resources :payloads, only: [:create, :show]
  end

end
