class MessagesController < ApplicationController
  def index
    @messages = Message.where(candidate_id: current_candidate.id).group(:headhunter_id)
  end
  
  def create
    @message = Message.new(params.permit(:content, :candidate_id))
    sent_by = headhunter_signed_in? ? 0 : 1  
    
    @message.sent_by = sent_by

    if sent_by == 0
      @message.headhunter_id = current_headhunter.id
    else
      @message.headhunter_id = params[:headhunter_id]
    end
    
    if @message.save
      redirect_to candidate_path(@message.candidate_id, headhunter_id: @message.headhunter_id)
    else
      render candidate_path(@message.candidate_id, headhunter_id: @message.headhunter_id)
    end

  end
end