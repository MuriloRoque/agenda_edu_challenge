module Api::V1
  class UsersController < ApiController
    def profile
      render json: @current_user
    end
  end
end
