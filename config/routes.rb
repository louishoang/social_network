Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  get 'weather', to: 'home#weather', as: 'weather'

  resources :users
  
  resources :posts do
    resources :comments
  end


end
