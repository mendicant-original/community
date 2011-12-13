class LearningMaterialsController < ApplicationController
  before_filter :find_learning_material, :only => admin_actions + [:show]
  before_filter :admin_required,         :only => admin_actions

  def index
    @lm = LearningMaterial.order("name")

    unless params[:filter].blank?
      @lm = @lm.where("name ILIKE :filter OR description ILIKE :filter",
        :filter => "%#{params[:filter]}%"
      )
    end

    @lm = @lm.paginate(:page => params[:page], :per_page => 20)
    @lm = LearningMaterialDecorator.decorate(@lm)

    respond_to do |format|
      format.js do
        @results = render_to_string(:partial => "learning_materials").html_safe
        render 'shared/update_list'
      end
      format.html
    end
  end

  def show
    @lm = LearningMaterialDecorator.decorate(@lm)
  end
  def edit;end

  def new
    @lm = LearningMaterial.new
  end

  def create
    @lm = LearningMaterial.new(params[:learning_material])

    if @lm.save
      flash[:notice] = "Learning Material sucessfully created"
      redirect_to learning_material_path(@lm.slug)
    else
      render :action => :new
    end
  end

  def update
    if @lm.update_attributes(params[:learning_material])
      flash[:notice] = "Learning Material sucessfully updated"
      redirect_to learning_material_path(@lm.slug)
    else
      render :action => :edit
    end
  end

  def destroy
    @lm.destroy

    flash[:notice] = "Learning Material sucessfully destroyed"
    redirect_to learning_materials_path
  end

  private

  def find_learning_material
    @lm = LearningMaterial.fuzzy_find(params[:id]) if params[:id]
  end
end
