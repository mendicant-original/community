class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :signed_in?, :admin?

  private

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.try(:id)
  end

  def admin?
    current_user && current_user.admin?
  end

  def user_required
    unless signed_in?
      store_location
      redirect_to login_path
    end
  end

  def admin_required
    unless admin?
      if current_user
        flash[:error] = "You must be an admin to access this area!"
        redirect_to root_path
      else
        store_location
        redirect_to login_path
      end
    end
  end

  def self.admin_actions
    [:new, :create, :edit, :update, :destroy]
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def access_denied
    flash[:alert] = "Sorry, you can't access this area"
    redirect_back_or_default root_path
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end
