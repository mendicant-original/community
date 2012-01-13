class ActivitiesController < ApplicationController
  before_filter :user_required
  before_filter :find_activity, :only => [:show, :edit, :update, :destroy, :register]

  def index
    @activities = Activity.includes(:author).order("created_at desc").
                  paginate(:page => params[:page])
    @activities = ActivityDecorator.decorate(@activities)
  end

  def register
    registration = @activity.activity_registrations.
      where(:user_id => current_user.id)

    if registration.any?
      registration.first.destroy
    else
      registration.create
    end

    @activity = ActivityDecorator.decorate(@activity)

    respond_to do |format|
      format.js
    end
  end

  private

  def find_activity
    @activity = Activity.find_by_slug(params[:id])
  end
end
