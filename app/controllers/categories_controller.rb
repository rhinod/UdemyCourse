class CategoriesController < ApplicationController

    def new
      @category = Category.new
    end

    def index
    end

    def show
      @category = Category.findby(params)
    end

    def create
        @category = Category.new(category_params)

        if @category.save
          flash[:notice] = "Categoria hecha"
          redirect_to @category
        else
          render 'new'
        end
    end

    private 
    def category_params
      params.require(:category).permit(:name)
    end


end