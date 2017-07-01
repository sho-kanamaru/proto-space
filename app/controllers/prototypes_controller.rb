class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
    @prototype.captured_images.build
  end

  def create
    @prototype = Prototype.new(create_params)
    if @prototype.save
      redirect_to root_path, notice: "posted your prototype in successfully."
    else
      flash.now[:alert] = "cannot posted your prototype"
      render :new
    end
  end

  private
    def create_params
      params.require(:prototype).permit(:title, :catch_copy, :concept, captured_images_attributes: [:content, :status]).merge(user_id: current_user.id)
    end
end
