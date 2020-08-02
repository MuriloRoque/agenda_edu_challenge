class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  before_action :configure_permitted_parameters


  protected


  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [
        :name,
        :password,
        :email
      ])
    end

end
