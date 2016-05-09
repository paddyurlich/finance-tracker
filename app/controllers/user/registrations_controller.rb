class User::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:first_name, :last_name)
    devise_parameter_sanitizer.for(:account_update).push(:first_name, :last_name)
  end
end

#note this controller was added manually to modify the functionality of the devise gem ie to add first name and last name. 
