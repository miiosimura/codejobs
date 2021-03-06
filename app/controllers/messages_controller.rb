class MessagesController < ApplicationController
  before_action :authenticate_both!

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
      @messages = current_headhunter.messages.where(candidate_id: params[:candidate_id])

    elsif candidate_signed_in?
      @messages = current_candidate.messages.where(headhunter_id: params[:headhunter_id])
    end
  end

  def new
    @message = Message.new()
  end
  
  def create
    if headhunter_signed_in?
      @message = Message.new(params.permit(:content, :candidate_id))
      @message.sent_by = 0
      @message.headhunter_id = current_headhunter.id
      
      if @message.save
        redirect_to candidate_messages_path
      else
        render :new
      end

    elsif candidate_signed_in?
      @message = Message.new(params.permit(:content, :headhunter_id))  
      @message.sent_by = 1
      @message.candidate_id = current_candidate.id

      if @message.save
        redirect_to headhunter_messages_path
      else
        render :new
      end
    end
  end

  private 
  def authenticate_both!
    if candidate_signed_in? || headhunter_signed_in?
      true
    else
      flash[:alert] = 'Para essa ação, é necessário estar logado'
      redirect_to root_path
    end
  end
end