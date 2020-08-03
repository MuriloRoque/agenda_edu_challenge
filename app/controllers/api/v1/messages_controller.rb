module Api::V1
  class MessagesController < ApiController

    def index
      if @current_user.permission == 'master'
        render json: Message.master_messages
      else
        render json: @current_user.messages
      end
    end

  end
end