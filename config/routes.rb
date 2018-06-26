Rails.application.routes.draw do
  resources :returns do
    collection do 
      get :return_type_report
      get :select_return_type
    end
  end
  resources :deliveries do
    member do
      get :record_payment
      get :payment
    end
     collection do
      get :new_delivery
      get :select_vendor
      get :payment_status_report
      get :export_payment
    end
  end
  resources :inwards do
    collection do
      get :load_item_data
      get :stock
    end
  end
  resources :vendors do
    collection do
      get :load_vendor
    end
  end
  
  resources :reports do 
    collection do
      get :export
      get :export_return
      get :export_delivery
    end
  end
  resources :employees
  resources :products do
    collection { post :import }
    
  end
  resources :companies
  get 'home/dashboard'

  devise_for :users
  root 'home#dashboard'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
