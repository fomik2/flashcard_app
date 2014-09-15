class Dashboard::CategoriesController < Dashboard::BaseController

  before_action :find_category, except: [:new, :create, :index]
  
  def new
    @category = current_user.categories.new
  end
  
  def index
    @categories = current_user.categories.order('name')
  end

  def create
    @category = current_user.categories.new(category_params)
    if @category.save
      flash[:success] = 'Карточка успешно добавлена'
      redirect_to root_path(@category)
    else
      flash[:error] = 'Что-то пошло не так'
      render 'new'
    end 
  end
  
  def edit 
  
  end

  def update
    if @category.update(category_params)
      redirect_to dashboard_categories_path
    else
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    redirect_to dashboard_categories_path
  end
  
private
  
  def category_params 
    params.require(:category).permit(:name, :about)
  end

  def find_category
    @category = current_user.categories.find(params[:id])
  end

end
