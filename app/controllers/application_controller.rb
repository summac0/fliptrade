class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :mailbox, :conversation

private

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

protected

  def configure_permitted_parameters

  devise_parameter_sanitizer.for(:sign_up) { |u| u.permit({ roles: [] }, :email, :password, :password_confirmation,
    :name, :username, :role) }

  devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation,
    :current_password, :name, :username, :role) }

  end

end
