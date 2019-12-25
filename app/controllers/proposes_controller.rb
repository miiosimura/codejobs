class ProposesController < ApplicationController
  def show
    @propose = Propose.find(params[:id])
  end
  
  def new
    @propose = Propose.new
  end

  def create
    @propose = Propose.new(params.require(:propose).permit(:subscription_id, :candidate_id, :start_date, :salary, :benefit, :function, :company_expectation, :bonus))
    @propose.headhunter_id = current_headhunter.id

    if @propose.save
      redirect_to candidate_path(@propose.candidate_id, headhunter_id: @propose.headhunter_id, subscription_id: @propose.subscription_id)
    else
      render :new
    end
  end

  def accept
    @propose = Propose.find(params[:id])
    reject_subscriptions(@propose.candidate, @propose)
    @propose.update(accepted: true)
    redirect_to job_path(@propose.subscription.job)
  end

  def edit_denial
    @propose = Propose.find(params[:id])
  end

  def denial
    @propose = Propose.find(params[:id])
    @propose.update(accepted: false, denial_reason: params[:denial_reason])
    redirect_to job_path(@propose.subscription.job_id)
  end

  private
  def reject_subscriptions(candidate, accepted_propose)
    candidate.proposes.each do |propose|
      unless propose == accepted_propose
        propose.update(accepted: false, denial_reason: 'Candidato aceitou outra proposta')
      end
    end
  end
end
