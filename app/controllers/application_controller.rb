class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :signed_in?, :admin?, :login_path

  before_filter :update_unread_count

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
      redirect_to login_path
      return true
    end
  end

  def admin_required
    unless admin?
      if current_user
        flash[:error] = "You must be an admin to access this area!"
        redirect_to root_path
      else
        redirect_to login_path
      end
    end
  end

  def self.admin_actions
    [:new, :create, :edit, :update, :destroy]
  end

  def update_unread_count
    @inbox = Inbox.new(current_user)
  end

  def login_path
    Rails.env.development? ? '/auth/developer' : '/auth/github'
  end
end
