class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def require_admin!
    redirect_to root_path, alert: "管理者のみアクセスできます" unless current_user&.admin?
  end

  def can_edit?(record)
    current_user.admin? || record.user_id == current_user.id
  end
  helper_method :can_edit?
end
