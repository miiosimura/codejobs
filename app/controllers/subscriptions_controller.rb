class SubscriptionsController < ApplicationController
  def index
    @active_subscriptions = Subscription.where(candidate_id: current_candidate.id)
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
end