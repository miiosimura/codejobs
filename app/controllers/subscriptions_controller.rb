class SubscriptionsController < ApplicationController
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
end
