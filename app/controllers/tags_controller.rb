class TagsController < ApplicationController

  def index
    @tags = Tag.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.find_or_create_by_tag_word(tag_word)
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
  end

end