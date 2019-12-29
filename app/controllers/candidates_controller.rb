class CandidatesController < ApplicationController
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
end
