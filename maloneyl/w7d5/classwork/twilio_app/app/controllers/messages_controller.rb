class MessagesController < ApplicationController

  def create
    TextMessage.new(params[:content], params[:number]).send
    redirect_to new_message_path
  end

end
