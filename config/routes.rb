Rails.application.routes.draw do

  namespace :api do
    resources :notificators, only: [] do
      resources :payloads, only: [:create]
    end
  end

end
