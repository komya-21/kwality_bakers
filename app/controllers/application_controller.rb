class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception
  before_action :authenticate_user!
  protect_from_forgery with: :null_session, if: Proc.new {|c| c.request.format.json? }

  def after_sign_out_path_for(resource_or_scope)
  	"/users/sign_in"
  end
end
