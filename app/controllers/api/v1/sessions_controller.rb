class Api::V1::SessionsController < Devise::SessionsController
   skip_before_action :verify_signed_out_user
  skip_before_action :verify_authenticity_token,  :if => Proc.new { |c| c.request.format == 'application/json' }
                     

  respond_to :json
 

  def create
   
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    if current_user.role == "Employee"
    render :status => 200,
           :json => { :success => true,
                      :info => "Logged in",
                      :data => { :auth_token => current_user.authentication_token,:email => current_user.email,:id => current_user.id,:employee_type => current_user.employee.employee_type,:employee_id => current_user.employee.id } }
                    else
                      render :status => 200,
           :json => { :success => true,
                      :info => "Logged in",
                      :data => { :auth_token => current_user.authentication_token,:email => current_user.email,:id => current_user.id} }
  end
end

  def destroy
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    current_user.update_column(:authentication_token, nil)
    render :status => 200,
           :json => { :success => true,
                      :info => "Logged out",
                      :data => {} }
  end

  def failure
    render :status => 401,
           :json => { :success => false,
                      :info => "Login Failed",
                      :data => {} }
  end
end