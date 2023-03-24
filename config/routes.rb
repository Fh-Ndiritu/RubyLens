Rails.application.routes.draw do
  get 'about/index'
  
  resources :jobs, only: [:index, :show]
  root to: 'jobs#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/start', to: 'crawler#start'
end
