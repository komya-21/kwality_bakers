Rails.application.routes.draw do
  resources :color_locations
  resources :locations
  resources :rates
  resources :workorders do 
    member do
      get :record_payment_workorder
      get :workorder_pdf
      get :workorder_status
      get :workorder_invoice
      get :proforma_invoice
      get :invoice
      get :invoicee
     
    end
    collection do
      post :order_report
      get :addition
      get :order_status
      get :location_report
      post :end_time
      post :status_update
      post :edit_rate
       post :add
       patch :update_additional
       get :invoice_list
       get :payment_status_report
       get :workorder_status_report



    end
  end
  resources :furnitures
  resources :work_orders do 
    collection do
      get :new_page
      get :furniture_dropdown
    end
  end
  resources :colors
  resources :returns do
    collection do 
      get :return_type_report
      get :select_return_type
      get :export_return
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
      get :todays_delivery
      get :export_delivery_index
      get :record_payment_all
    end
  end
  resources :inwards do
    collection do
      get :load_item_data
      get :stock
      get :export_inward
    end
  end
  resources :vendors do
    collection do
      get :load_vendor
      post :create_vendor
    end
  end
  resources :current_inventories do
    collection do
      get :export_stock
      get :reset_all
    end
    member do
      get :new1
      get :reset
    end
  end
  
  resources :reports do 
    collection do
      get :export
      get :export_return
      get :export_delivery
      get :export_custom
      get :export_regular
      get :export_all_vendor
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
