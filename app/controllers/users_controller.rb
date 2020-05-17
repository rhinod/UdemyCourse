class UsersController < ApplicationController
    def new
      @user = User.new 
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:notice] = "Tu cuenta ha sido actualizada"
        redirect_to articles_path
      else
        render 'edit'
      end
    end

    def create
      @user = User.new(user_params)

      if @user.save
        flash[:notice] = "Bienvenido a alphablog #{user.username}"
        redirect_to root_path
      else
        render 'new'
      end
    end

    

    private 
    def user_params
      params.require(:user).permit(:username,:email,:password)
    end
end


