module MessagesHelper
  def setMainMsg(conversation, sender)
    msg = {}
    ttl = conversation.advertisement.title
    owner_name = conversation.advertisement.user.name
    sender_name = sender.name

    if conversation.recipient_id == current_user.id
      msg['title'] = "”#{ttl}” の広告依頼をみた、<br>#{sender_name}さんからメッセージが届きました！"
      msg['comment'] = "#{sender_name}さんから、あなたの広告依頼を受けたいという
                       オファーが来ております。メッセージを返しましょう。
                       正式に依頼したい場合は「#{sender_name}さんに依頼する！」を押してください。"
    elsif conversation.sender_id == current_user.id
      msg['title'] = "#{ttl}の広告依頼について、<br>#{owner_name}さんにメッセージを送ろう！"
      msg['comment'] = "#{owner_name}さんに広告依頼を受けたいというオファーを出しましょう。"
    end

    msg
  end
end
