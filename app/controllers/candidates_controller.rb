class CandidatesController < ApplicationController
  def show
    @candidate = Candidate.find(params[:id])
    # @messages = Message.where(candidate_id: @candidate.id, headhunter_id: params[:headhunter_id])
    @messages = @candidate.messages.where(headhunter_id: params[:headhunter_id])
    #@propose = Propose.where(candidate_id: @candidate.id, headhunter_id: current_headhunter, subscription_id: params[:subscription_id])
    @propose = @candidate.proposes.find_by(subscription_id: params[:subscription_id])
  end
  
  def edit
    @candidate = current_candidate
  end
  
  def update
    if current_candidate.update(params.require(:candidate).permit(:name, :birthday, :scholarity, :work_experience, :job_interest))
      redirect_to root_path
    else
      @candidate = current_candidate
      render :edit
    end
  end
end
