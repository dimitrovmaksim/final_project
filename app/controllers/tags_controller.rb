class TagsController < ApplicationController
  skip_before_action :authorize, only: [:show]
  skip_before_action :check_admin, only: [:show]

  def index
    @tags = Tag.order('LOWER(name)')
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def destroy
    @tag = Tag.find(params[:id])

    @tag.destroy
    redirect_to tags_path, notice: "Tag deleted!"
  end
end
