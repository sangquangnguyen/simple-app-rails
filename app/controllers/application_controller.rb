class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  helper_method :logged_in?, :current_user

  def current_user
    Employee.find_by(id: session[:user_id])
  end

  def require_user_logged_in!
    # allows only logged in user
    redirect_to login_path, alert: 'You must be signed in' if current_user.nil?
  end

  def logged_in?
    !current_user.nil?
  end

  private

  def user_not_authorized
    flash[:warning] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end
end
