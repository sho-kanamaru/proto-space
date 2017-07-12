class Prototypes::NewestController < ApplicationController
  def index
    @prototypes = Prototype.page(params[:page]).per(8).order("created_at DESC")
  end
end
