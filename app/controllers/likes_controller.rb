class LikesController < ApplicationController
  def create
    @prototype = Prototype.find(params[:prototype_id])
    @like = @prototype.likes.create(user_id: current_user.id)
  end

  def destroy
    @prototype = Prototype.find(params[:prototype_id])
    @prototype.likes.find_by(user_id: current_user.id).destroy
  end
end
