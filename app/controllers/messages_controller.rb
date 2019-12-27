class MessagesController < ApplicationController
  def index
    if headhunter_signed_in?
      @messages = Message.where(headhunter_id: current_headhunter.id).group(:candidate_id)
    elsif candidate_signed_in?
      @messages = Message.where(candidate_id: current_candidate.id).group(:headhunter_id)
    end
  end

  def show
    # @messages = Message.where(candidate_id: @candidate.id, headhunter_id: params[:headhunter_id])
    if headhunter_signed_in?
      @headhunter = Headhunter.find(params[:id])
      @messages = @headhunter.messages.where(candidate_id: params[:candidate_id])

    elsif candidate_signed_in?
      @candidate = Candidate.find(params[:id])
      @messages = @candidate.messages.where(headhunter_id: params[:headhunter_id])
    end
  end

  def new
    @message = Message.new
  end
  
  def create
    if headhunter_signed_in?
      @message = Message.new(params.permit(:content, :candidate_id))
      @message.sent_by = 0
      @message.headhunter_id = current_headhunter.id
      
      if @message.save
        redirect_to message_path(current_headhunter, candidate_id: @message.candidate_id)
      else
        render :new
      end

    elsif candidate_signed_in?
      @message = Message.new(params.permit(:content, :headhunter_id))  
      @message.sent_by = 1
      @message.candidate_id = current_candidate.id

      if @message.save
        redirect_to message_path(current_candidate, headhunter_id: @message.headhunter_id)
      else
        render :new
      end
    end
  end
end