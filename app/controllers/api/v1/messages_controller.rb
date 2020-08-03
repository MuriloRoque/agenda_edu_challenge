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
      if @current_user.permission != 'master'
        return unless @current_user == message.receiver

      end
      render json: message
    end

    def sent
      messages = if @current_user.permission == 'master'
                   Message.ordered
                 else
                   Message.sent_from(@current_user).ordered
                 end
      render json: messages
    end
  end
end
