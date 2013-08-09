class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @colors = Cat.colors
    @sexes = Cat.sexes
    render :new
  end

  def create
    @cat = Cat.create(params[:cat])
    if @cat
      redirect_to cat_url(@cat)
    else
      render :text => "invalid cat", :status => :unprocessable_entity
    end
  end

  def edit
    @cat = Cat.find_by_id(params[:id]).includes(:rental_requests)
    @colors = Cat.colors
    @sexes = Cat.sexes
    render :edit
  end

  def update
    @cat = Cat.find_by_id(params[:id])
    @cat.update_attributes(params[:cat])
    @cat.save!
    render :show
  end

  def destroy
    @cat = Cat.find_by_id(params[:id])
    @cat.destroy
    render :destroy
  end
end
