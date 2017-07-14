class Prototypes::NewestController < ApplicationController
  def index
    @prototypes = Prototype.includes(:user).page(params[:page]).per(8).order(created_at: :DESC)
  end
end
