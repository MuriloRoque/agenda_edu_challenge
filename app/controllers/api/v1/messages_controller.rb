module Api::V1
  class MessagesController < ApiController

    def index
      if @current_user.permission == 'master'
        render json: Message.master_messages
      else
        render json: @current_user.messages
      end
    end

    def show
      message = Message.find(params[:id])
      if @current_user.permission == 'master'
        render json: message
      else
        return unless @current_user == message.receiver
        render json: message
      end
    end

  end
end