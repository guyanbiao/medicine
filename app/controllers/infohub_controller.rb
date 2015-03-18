class InfohubController < ApplicationController
  before_action :authenticate_user!
  def replies
    render json: {}
  end

  def  activities
    render json: current_user.foot_points.map {|x|{ 
      activity_type: (x.element_type == "Tweet" ? 0 : 1),
      content: x.real_member.content,
      id: x.real_member.id.to_s
    }}
  end

  def messages
    json = current_user.received_messages.unread.map {|x| {
      username: x.sender.username,
      avatar: x.sender.avatar,
      content: x.content, sesson_id: x.chat_session_id.to_s,
      created_at: x.created_at
    }}
    render json: json
  end

  def show_message
    session = ChatSession.find params[:session_id]
    render json: session.messages.map {|x| {
      avatar: x.sender.avatar,
      username: x.sender.username,
      content: x.content,
      created_at: x.created_at,
      me: (x.sender == current_user)
    }}
  end

  def create_message
    sender = current_user
    receiver = User.find params[:receiver_id]
    message = Message.where(sender: sender, receiver: receiver).first
    if message
      chat_session = message.chat_session
    else
      chat_session = ChatSession.create
    end
    m = Message.new(sender: sender,
                   receiver: receiver,
                   content: params[:content],
                   chat_session: chat_session
                  )
    if m.save
      render json: {}
    else
      render json: m.errors.full_messages
    end
  end
end
