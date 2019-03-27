module ApplicationHelper
  def simple_time(time)
    time.strftime("%Y.%m.%d")
  end

  def detail_time(time)
    time.strftime("%Y.%m.%d %H:%M")
  end

  def start_time(time)
    time.strftime("%Y年%m月")
  end

  def checkUser(obj)
    if obj.user.id == current_user.id
      return 'type_i'
    else
      return 'type_you'
    end
  end

  def setMsgBadge
    conversations = Conversation.all
    notReadMsgCount = 0
    conversations.each do |conversation|
      if conversation.target_user(current_user).present? && conversation.CheckRead(current_user)
        notReadMsgCount += conversation.CheckRead(current_user).to_i
      end
    end
    notReadMsgCount != 0 ? "#{notReadMsgCount}" : false
  end
end
