Rails.application.routes.draw do
  devise_for :users
  resources :portfolios
  get 'pages/home'

  get 'about-me', to: 'pages#about'
  get 'contact', to: 'pages#contact'

  resources :blogs do
    member do
      get :toggle_status
    end
  end
end
