class TagsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :set_tag, only: %i[edit destroy update]
  before_action :only_admin, except: %i[index]

  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to tags_path
    else
      render :new
    end
  end

  def edit; end

  def update
    @tag.update(tag_params)
    redirect_to tags_url
  end

  def destroy
    @tag.destroy
    redirect_to tags_url
  end

  private

  def tag_params
    params.require(:tag).permit(:name, :description)
  end

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def only_admin
    redirect_to products_path unless user_signed_in? && current_user.admin
  end
end
