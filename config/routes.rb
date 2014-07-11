Rails.application.routes.draw do

  namespace :api do
    resources :notificators, only: [] do
      resources :payloads, only: [:create, :show]
    end
  end

end
