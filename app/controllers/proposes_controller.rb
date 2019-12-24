class ProposesController < ApplicationController
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
end