class Prototypes::NewestController < ApplicationController
  def index
    @prototypes = Prototype.includes(:user).page(params[:page]).recent
  end
end
