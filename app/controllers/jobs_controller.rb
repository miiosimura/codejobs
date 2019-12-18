class JobsController < ApplicationController
  def index
    @jobs = Job.where(headhunter_id: current_headhunter.id)
  end

  def show
    @job = Job.find(params[:id])
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
end
