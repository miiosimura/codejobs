class SubscriptionsController < ApplicationController
  before_action :authenticate_both!, only: [:index]
  before_action :authenticate_candidate!, only: [:new, :create]
  before_action :authenticate_headhunter!, only: [:change_featured_profile, :edit_denial, :denial]
  
  def index
    @subscriptions = Subscription.where(candidate_id: current_candidate.id)
  end

	def new
    @subscription = Subscription.new
	end

  def create
    @subscription = Subscription.new(params.permit(:about_candidate, :job_id))
    @subscription.candidate_id = current_candidate.id

    if @subscription.save
      flash[:notice] = 'Obrigada pela sua inscrição. Em breve o recrutador entrará em contato!'
      redirect_to subscriptions_path
    else
      render :new
    end
  end
  
  def change_featured_profile
    @subscription = Subscription.find(params[:id])

    if @subscription.featured_profile
      @subscription.featured_profile = false
    else
      @subscription.featured_profile = true
    end

    @subscription.save
    redirect_to job_path(@subscription.job_id)
  end

  def edit_denial
    @subscription = Subscription.find(params[:id])
  end

  def denial
    @subscription = Subscription.find(params[:id])
    @subscription.update(params.permit(:denial_reason))
    redirect_to job_path(@subscription.job_id)
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