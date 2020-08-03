module Api::V1
  class UsersController < ApiController
    def profile
      render json: @current_user
    end

    def update
      if user_params[:password].blank? || user_params[:password_confirmation].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end

      if @current_user.update(user_params)
        render json: @current_user
      else
        render json: @current_user.errors
      end
    end

    private

    def user_params
      params.require(:user).permit(
        :name,
        :email,
        :password,
        :password_confirmation
      )
    end
  end
end
