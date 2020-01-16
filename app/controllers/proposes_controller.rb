class ProposesController < ApplicationController
  before_action :authenticate_both!, only: [:show]
  before_action :authenticate_headhunter!, only: [:new, :create]
  before_action :authenticate_candidate!, only: [:accept, :edit_denial, :denial]
  
  def show
    @propose = Propose.find(params[:id])
  end
  
  def new
    @propose = Propose.new
  end

  def create
    @propose = Propose.new(params.require(:propose).permit(:start_date, :salary, :benefit, :function, :company_expectation, :bonus))
    @propose.subscription_id = params[:subscription_id]

    if @propose.save
      redirect_to candidate_path(@propose.subscription.candidate_id, subscription_id: params[:subscription_id])
    else
      render :new
    end
  end

  def accept
    @propose = Propose.find(params[:id])
    reject_subscriptions(current_candidate, @propose)
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
    subscriptions = candidate.subscriptions.where.not(id: accepted_propose.subscription_id)

    subscriptions.each do |subscription|
      propose = Propose.find_by(subscription_id: subscription)
      if !propose.nil?
        propose.update(accepted: false, denial_reason: 'Candidato aceitou outra proposta')
      end
    end
  end

  def authenticate_both!
    if candidate_signed_in? || headhunter_signed_in?
      true
    else
      flash[:alert] = 'Para essa ação, é necessário estar logado'
      redirect_to root_path
    end
  end
end
  