class CategoriesController < ApplicationController

  before_action :find_category, except: [:new, :create, :index]
  
  def new
    @category = Category.new
  end
  
  def index
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    @category.name = @category.name.capitalize
    @category.about = @category.about.capitalize
    if @category.save
      flash[:result] = true
      redirect_to root_path
    else
      flash[:result] = false
      render 'new'
    end 
  end
  
  def edit 
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path
  end

private
  
  def category_params 
    params.require(:category).permit(:name, :about)
  end

  def find_category
    @category = Category.find(params[:id])
  end

end
