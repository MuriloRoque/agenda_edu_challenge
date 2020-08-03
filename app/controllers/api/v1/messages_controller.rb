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

    def create
      user = User.find_by_email(message_params[:receiver_email])
      message = Message.new(message_params.merge(from: @current_user.id))
      message.to = user.id if user

      if message.save
        render json: message
      else
        render json: message.errors
      end
    end

    def sent
      messages = if @current_user.permission == 'master'
                   Message.ordered
                 else
                   Message.sent_from(@current_user).ordered
                 end
      render json: messages
    end

    private

    def message_params
      params.require(:message).permit(
        :title,
        :content,
        :receiver_email,
        :to
      )
    end
  end
end
