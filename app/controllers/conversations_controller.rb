class ConversationsController < ApplicationController

  before_action :set_user, :logged_in_user
  helper_method :mailbox, :conversation

  layout 'scaffold_layout', :only => [:index]



  def index
   @mailbox ||= mailbox
   @conversations = @mailbox.conversations.paginate(page: params[:page], per_page: 7  )
   
 end

 def new
  if params[:receiver_id]
    receiver_user = User.find(params[:receiver_id]) 
    @email = receiver_user.email
  end
end



def create

  recipient_emails = conversation_params(:recipients).split(',')
  recipients = User.where(email: recipient_emails).all

  if recipients.include?(current_user) or recipients.empty?

    flash[:danger] = "다시 초대해 주세요 :)"

redirect_to conversations_path
elsif @conversation = already_have_conversation?(recipients)
  @body = conversation_params(:body)
  @user.reply_to_conversation( @conversation, @body )
  redirect_to conversation_path(@conversation)

  else
  @conversation = @user.send_message(recipients, *conversation_params(:body, :subject)).conversation
  title = "#{current_user.name}님이 답장을 보냈습니다. "
  message = conversation_params(:body) + "<a href ='/conversations/#{@conversation.id}'>보러가기</a> "
  recipients.each do |recipient|
  ##Pusher.trigger("mychannel-#{recipient.id}", 'my-event', {:type => "new_message", :title=>title , :message => message, :url => current_user.gravatar_url, :id=>@conversation.id } ) 
  recipient.notify("#{current_user.name}님이 메세지를 보냈습니다." , "/conversations/#{@conversation.id}")
  end


redirect_to conversation_path(@conversation)
end 



end



def reply


  @receipt= @user.reply_to_conversation(conversation, *message_params(:body, :subject))
  title = "#{current_user.name}님이 답장을 보냈습니다. "
  message = @receipt.message.body + "<a href ='/conversations/#{conversation.id}'>보러가기</a>"
  

  conversation.participants.each do |participant|

    unless current_user?participant


      #Pusher.trigger("mychannel-#{participant.id}", 'my-event', {:type => "new_message", :title=>title , :message => message, :url => current_user.gravatar_url , :c_id=> @receipt.id }  )
      participant.notify("#{current_user.name}님이 답장을 보냈습니다. " , "/conversations/#{conversation.id}")

    end
  end
  respond_to do |format|
    format.html { redirect_to conversation_path(conversation) }
    format.js
  end
  
  
end

def show

  conversation.mark_as_read(@user)
  #Pusher.trigger("mychannel-#{current_user.id}", 'my-event', {:type => "is_read", :title=>"title" , :message => "message", :url => current_user.gravatar_url , :c_id=> '@receipt.id' } )

end


def trash
  conversation.move_to_trash(@user)
  redirect_to :conversations
end

def untrash
  conversation.untrash(@user)
  redirect_to :conversations
end


def mark_read
  if params[:type]
    current_user.mailbox.notifications.each do |notification|
      notification.mark_as_read current_user
    end 
  elsif params[:id]
  @notification = current_user.mailbox.notifications.find(params[:id])
  @notification.mark_as_read current_user
  redirect_to @notification.body
  end
redirect_to root_path
end

def readable_off

  @user.redable_off

end


private

def mailbox
  @mailbox ||= @user.mailbox
end

def conversation
  # ids = mailbox.conversations.ids
  # id = params[:id].to_i
  # if ids.include?id

  @conversation = mailbox.conversations.find(params[:id])

# else
#   flash[:danger] = "다른 유저들의 방은 안되여 :("
#   redirect_to conversations_path
# end

end

def conversation_params(*keys)
  fetch_params(:conversation, *keys)
end

def message_params(*keys)
  fetch_params(:message, *keys)
end


def already_have_conversation?(recipients)

  conversations = mailbox.conversations
  conversations.each do |conversation|
    participants = conversation.participants
    participants.delete(@user)
    if recipients == participants
      @conversation = conversation
      return @conversation
    end

  end
  
  return false
  
end






def fetch_params(key, *subkeys)
  params[key].instance_eval do
    case subkeys.size
    when 0 then self
    when 1 then self[subkeys.first]
    else subkeys.map{|k| self[k] }
    end
  end
end

def correct_user
  unless conversation
    flash[:danger] = "잘 못된 접근 :("
      redirect_to conversations_path

    end
  end


  def set_user
    @user ||= current_user
  end


end