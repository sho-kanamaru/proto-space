class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
  end

  def new
    @prototype = Prototype.new
  end
end
