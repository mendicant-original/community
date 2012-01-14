class ActivitiesController < ApplicationController
  before_filter :user_required
  before_filter :find_activity, :only => [:show, :edit, :update, :destroy, :register]
  before_filter :authorized_users_only, :only => [:edit, :update, :destroy]

  def index
    @activities = Activity.includes(:author).order("created_at desc").
                  paginate(:page => params[:page])
    @activities = ActivityDecorator.decorate(@activities)
  end

  def show
    @activity = ActivityDecorator.decorate(@activity)
  end


  def new
    @activity = Activity.new
  end

  def edit
  end

  def create
    @activity = current_user.activities.build(params[:activity])

    if @activity.save
      redirect_to(@activity, :notice => 'Activity was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    if @activity.update_attributes(params[:activity])
      redirect_to(@activity, :notice => 'Activity was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @activity.destroy
    redirect_to(activitys_path, :notice => 'Activity was successfully destroyed.')
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

  def authorized_users_only
    unless @activity.editable_by?(current_user)
      redirect_to activities_path,
        :alert => "You are not authorized to edit other user's activities!"
    end
  end
end
