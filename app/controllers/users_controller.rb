class UsersController < ApplicationController
    def create 
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
        else 
            render json: {error: user.errors.full_messages}, status: :unprocessable_entity
        end
    end

    # def show 
    #     user = User.find_by(username: params[:username])
    #     if user&.athenticate(params[:password])
    #         render json: user,  status: :ok
    #     else 
    #         render json: {error: "User not found"}, status: :unauthorized
    #     end
    # end
    def show
    if session[:user_id]
        user = User.find_by(id: session[:user_id])
        render json: user, status: :ok
    else
        render json: { error: "User not logged in" }, status: :unauthorized
    end
    end



    private
    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
end
