class JobsController < ApplicationController
  def index
    @jobs = Job.where(headhunter_id: current_headhunter.id)
  end

  def show
    @job = Job.find(params[:id])
    @subscription = Subscription.find_by(job_id: @job, candidate_id: current_candidate)
  end

  def new
    @job = Job.new
  end
  
  def create
    @job = Job.new(params.require(:job).permit(:title, :job_description, :skills_description, :salary_min, :salary_max, :job_level, :subscription_date, :city))
    @job.headhunter_id = current_headhunter.id
    
    if @job.save
      flash[:notice] = 'Nova vaga cadastrada com sucesso!'
      redirect_to @job
    else
      render :new
    end
  end

  def search
    if params[:q].length > 1
      @jobs = Job.where('title like ?', "%#{params[:q]}%")
      render :search
    end
  end
end
