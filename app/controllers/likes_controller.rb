class LikesController < ApplicationController
  def create
    @prototype = Prototype.find(params[:prototype_id])
    @like = @prototype.likes.create(user_id: current_user.id)
  end
end
