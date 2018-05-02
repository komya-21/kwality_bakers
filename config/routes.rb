Rails.application.routes.draw do
  resources :returns
  resources :deliveries do
    member do
      get :record_payment
      get :payment
    end
  end
  resources :inwards do
    collection do
      get :load_item_data
    end
  end
  resources :vendors do
    collection do
      get :load_vendor
    end
  end
  
  resources :employees
  resources :products
  resources :companies
  get 'home/dashboard'

  devise_for :users
  root 'home#dashboard'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
