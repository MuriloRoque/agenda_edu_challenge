module ApplicationHelper
  def active?(path)
    "active" if current_page?(path)
  end

  def message_date(message)
    message.created_at.to_date == Date.today ? message.created_at.to_s(:time) : message.created_at.strftime("%d/%m/%Y")
  end

  def user_messages
    current_user.master? ? Message.master_messages.size  : current_user.messages.unread.size
  end

  def archived_count
    Message.archived.size
  end

  def users_count
    User.normal.size
  end
end
