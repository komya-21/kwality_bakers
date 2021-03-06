Rails.application.routes.draw do


  devise_for :users
  namespace :api do
  namespace :v1 do
    devise_scope :user do
      post 'sessions' => 'sessions#create', :as => 'login'
      delete 'sessions' => 'sessions#destroy', :as => 'logout'
    end
  end
end
  resources :suppliers do 
    collection do
       post :create_supplier
     end
   end
  resources :payslips do 
    collection do
      get :employees
      get :employee_payslip
      get :select_emp

    end
    member do 
      get :monthly_payslip
      get :payslip_pdf
    end
  end
  resources :employee_payrolls do 
    collection do
      get :earnings
      get :deductions
    end
  end
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
      get :assigned_workorders
      get :workorder_measurement
      get :pending_workorders
      get :completed_workorders
      get :hold_workorders
      get :working_workorders
      get :workorder_info
      get :export_vendorwise_workorder
      get :employee_work
      post :order_report
      get :addition
      get :delete_all
      get :approve_all
      get :order_status
      get :location_report
      post :end_time
      post :status_update
      post :edit_rate
       post :add
       patch :update_additional
       patch :update_empwork
       get :invoice_list
       get :payment_status_report
       get :workorder_status_report
       post :delivery_status


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
      post :transaction_detail
       get :inward_transaction_detail
    end
    member do
      get :inward_record_payment

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
      get :export_workorder
      get :export_workorder_status
      get :export_locations_report
      get :export_delivery
      get :export_custom
      get :export_regular
      get :export_all_vendor
      get :export_payment_status
    end
  end
  resources :employees do
    collection do
      post :in_time
      get :employee_details
      post :create_empwork
      post :out_time
      get :empwork
      get :report
    end
    member do 
      patch :update_empwork
    end
  end
  resources :products do
    collection { post :import }
    
  end
  resources :companies
  get 'home/dashboard'
  get 'home/menu'

  root 'home#dashboard'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
