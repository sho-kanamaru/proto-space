class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_prototype, except: [:index, :new, :create]
  before_action :set_sub_images, only: [:edit, :update]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
    @prototype.captured_images.build
  end

  def create
    @prototype = current_user.prototypes.new(create_params)
    if @prototype.save
      redirect_to root_path, notice: "posted your prototype in successfully."
    else
      flash.now[:alert] = "cannot posted your prototype"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def destroy
    if @prototype.user_id == current_user.id
      @prototype.destroy
      redirect_to root_path, notice: "Prototype was successfully deleted."
    end
  end

  def update
    if @prototype.update(create_params)
      redirect_to root_path, notice: "Prototype was successfully updated."
    else
      flash.now[:alert] = "cannot updated your prototype"
      render :edit
    end
  end

  private
    def create_params
      params.require(:prototype).permit(:title, :catch_copy, :concept, captured_images_attributes: [:id, :content, :status])
    end

    def set_prototype
      @prototype = Prototype.find(params[:id])
    end

    def set_sub_images
      @sub_images = @prototype.get_sub_contents
    end
end
