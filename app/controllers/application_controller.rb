require "application_responder"
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :layout_by_resource
  self.responder = ApplicationResponder
  respond_to :html

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(resource)
    messages_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash.now[:danger] = "Acesso negado. Você não está autorizado a acessar essa página"
    redirect_to messages_path, flash: {danger: "Acesso negado. Você não está autorizado a acessar essa página"}
  end
  private

  def layout_by_resource
    if devise_controller?
      'login'
    else
      'application'
    end
  end
end
