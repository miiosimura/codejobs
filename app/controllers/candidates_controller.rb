class CandidatesController < ApplicationController
  before_action :authenticate_candidate!, except: [:show]
  before_action :authenticate_both!, only: [:show]
  
  def show
    @candidate = Candidate.find(params[:id])
    
    if headhunter_signed_in?
      @propose = Propose.find_by(subscription_id: params[:subscription_id])
      @subscription = Subscription.find(params[:subscription_id])
    end
  end
  
  def edit
    @candidate = current_candidate
  end
  
  def update
    if current_candidate.update(params.require(:candidate).permit(:name, :birthday, :scholarity, :work_experience, :job_interest, :photo))
      redirect_to candidate_path(current_candidate)
    else
      @candidate = current_candidate
      render :edit
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
