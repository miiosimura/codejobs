class SubscriptionsController < ApplicationController
  def index

  end

	def new
    @subscription = Subscription.new
	end

	def create
    # @subscription = Subscription.new(params.require(:subscription).permit(:))


    # params.require(:job).permit(:title, :job_description, :skills_description, :salary_min, :salary_max, :job_level, :subscription_date, :city))
	end
end
