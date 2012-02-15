class ActivitiesController < ApplicationController
  before_filter :user_required
  before_filter :find_activity, :only => [ :show, :edit, :update, :destroy,
                                           :register, :archive, :restore,
                                           :create_discussion_list ]
  before_filter :authorized_users_only, :only => [ :edit, :update, :destroy,
                                                   :archive, :restore,
                                                   :create_discussion_list ]

  def index
    @activities = Activity.active.includes(:author).order("created_at desc").
                  paginate(:page => params[:page])
    @activities = ActivityDecorator.decorate(@activities)
  end

  def archived
    @activities = Activity.archived.includes(:author).order("created_at desc").
                  paginate(:page => params[:page])
    @activities = ActivityDecorator.decorate(@activities)
  end

  def show
    @activity     = ActivityDecorator.decorate(@activity)
    participants  = @activity.approved_participants - [current_user]
    @participants = UserDecorator.decorate(participants)
    @user         = UserDecorator.decorate(current_user)

    @activity.mark_read_by!(current_user) if signed_in?
    set_unread_count
  end


  def new
    @activity = Activity.new(:registration_open => true)
  end

  def edit
    collect_users
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
      collect_users
      render :action => "edit"
    end
  end

  def destroy
    @activity.destroy
    redirect_to(activities_path, :notice => 'Activity was successfully destroyed.')
  end

  def archive
    @activity.update_attribute(:archived, true)
    redirect_to(activities_path, :notice => 'Activity was successfully archived.')
  end

  def restore
    @activity.update_attribute(:archived, false)
    redirect_to(activity_path(@activity), :notice => 'Activity was successfully restored.')
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
    @participating = @activity.approved_participants.include?(current_user)

    respond_to do |format|
      format.js
    end
  end

  def create_discussion_list
    @discussion_list = @activity.create_discussion_list(params[:name])

    respond_to do |format|
      format.js
    end
  end

  private

  def find_activity
    @activity = Activity.find_by_slug(params[:id])

    raise ActionController::RoutingError.new('Not Found') unless @activity
  end

  def authorized_users_only
    unless @activity.editable_by?(current_user)
      redirect_to activities_path,
        :alert => "You are not authorized to edit other user's activities!"
    end
  end

  def collect_users
    @users = User.order("name").map {|u| [u.name, u.id] }
  end
end
