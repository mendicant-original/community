class SessionsController < ApplicationController

  def create
    unless user = User.find_by_uid(auth_hash['uid'])
      user = User.create_from_hash(auth_hash)
    end

    self.current_user = user

    redirect_back_or_default root_path
  end

  def destroy
    self.current_user = nil

    redirect_to root_path
  end

  def failure
    flash[:error] = "There was a problem logging in. Please try again"

    self.current_user = nil # Try destroying the current_user

    redirect_to root_path
  end

  private

  def auth_hash
    hash = request.env['omniauth.auth']
    hash['uid'] = hash['uid'].to_s

    hash
  end

end
