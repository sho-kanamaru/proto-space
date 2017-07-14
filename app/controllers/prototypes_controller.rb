class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_prototype, except: [:index, :new, :create]
  before_action :set_sub_images, only: [:edit, :update]

  def index
    @prototypes = Prototype.includes(:user).page(params[:page]).per(8).order(likes_count: :DESC)
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
    @like = Like.find_by(user_id: current_user, prototype_id: params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
  end

  def destroy
    if @prototype.user_id == current_user.id
      @prototype.destroy
      redirect_to root_path, notice: "Prototype was successfully deleted."
    else
      render :index, alert: "cannot deleted the prototype"
    end
  end

  def update
    if @prototype.update(update_params)
      redirect_to root_path, notice: "Prototype was successfully updated."
    else
      flash.now[:alert] = "cannot updated your prototype"
      render :edit
    end
  end

  private
    def create_params
      params.require(:prototype).permit(:title, :catch_copy, :concept, captured_images_attributes: [:content, :status])
    end

    def update_params
      params.require(:prototype).permit(:title, :catch_copy, :concept, captured_images_attributes: [:id, :content, :status])
    end

    def set_prototype
      @prototype = Prototype.find(params[:id])
    end

    def set_sub_images
      @sub_images = @prototype.get_sub_contents
    end
end
