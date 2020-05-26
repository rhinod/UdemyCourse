class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show]

    def new
      @category = Category.new
    end

    def index
      #@categories = Category.all
      @categories = Category.paginate(page: params[:page], per_page: 6) 
    end

    def show
      @category = Category.find(params[:id])
      @category_articles = @category.articles.paginate(page: params[:page], per_page: 6)
    end

    

    def create
        @category = Category.new(category_params)

        if @category.save
          flash[:notice] = "Categoria hecha"
          redirect_to categories_path
        else
          render 'new'
        end
    end

    def edit
      @category = Category.find(params[:id])
    end

    def update
      @category = Category.find(params[:id])
      if @category.update(category_params)
        flash[:notice] = "Change created"
        redirect_to category_path(@category)
      else
        render 'edit'
      end
    end


    private 
    def category_params
      params.require(:category).permit(:name)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def require_admin
      if !logged_in? || (logged_in? and !current_user.admin?)
        flash[:danger] = "Please log in"
        redirect_to categories_path
      end
    end


end