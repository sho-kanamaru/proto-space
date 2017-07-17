class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.most_used
  end

  def show
    @tag =  ActsAsTaggableOn::Tag.find(params[:id])
    @prototypes = Prototype.tagged_with(@tag.name).page(params[:page]).like
  end
end
