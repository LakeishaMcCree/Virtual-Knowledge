class UsersController < ApplicationController
    before_action :must_be_admin

    def new
        @users = User.new
    end

    def create
        @user = User.new(user_params)
       if  
         @user.save
            session[:user_id] = @user.id
            redirect_to root_path
       else
        render :new
       end
    end



    private

    def must_be_admin 
        unless current_user.admin?
            redirect_to meetings_path, alert: "You don't have access to this page."
        end
    end

    def user_params
        params.require(:user).permit(:email, :password)
    end

end
