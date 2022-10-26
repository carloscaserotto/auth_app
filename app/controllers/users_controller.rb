class UsersController < ApplicationController

    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:new, :create, :show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]


    def index
        #@users = User.all
        #byebug
        @users = User.search(params[:search])
    end

    def show
        
    end

    def new
        @user = User.new
    end
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "Welcome #{@user.username}, you have successfully sign up"
            redirect_to users_path
        else
            render 'new'
        end

    end
 
    def edit
        
    end
    def update     
        if @user.update(user_params)
          redirect_to users_path
        else
          render 'edit'
        end
    end
    
    def destroy
        @user.destroy
        session[:user_id] = nil if @user == current_user
        flash[:notice] = "Account and all associated articles successfully deleted"
        redirect_to users_path
    end
    
    private
    def set_user 
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :email, :password, :admin, :search)
    end

    def require_same_user
        if current_user.username != @user.username && !current_user.admin?
            flash[:alert] = "You can only edit or delete your own user"
            redirect_to @user
        end
    end


    
end
