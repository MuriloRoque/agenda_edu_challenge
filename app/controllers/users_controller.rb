class UsersController < ApplicationController
  load_and_authorize_resource #cancancan permissions
  before_action :authenticate_user!
  before_action :set_user, except: [:index]

  # render edit form
  def edit
  end

  # update user info
  def update
    if user_params[:password].blank? || user_params[:password_confirmation].blank? # remove password if both fields are not filled
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update(user_params)
      bypass_sign_in(@user) # if user change password sign_in user again
      redirect_to messages_path, notice: 'Perfil editado com sucesso.'
    else
      redirect_to edit_user_path(id: @user.id), flash: {danger: 'Houve um erro.'}
    end
  end

  # get all non archived messages
  def index
    @users = User.normal
  end

  # get all messages non archived of a user , sent and received
  def messages
    @user = User.find(params[:id])
    @sent = Message.sent_from(@user).ordered
    @received = Message.sent_to(@user).ordered
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end

end
