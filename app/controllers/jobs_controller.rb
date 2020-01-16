class JobsController < ApplicationController
  before_action :authenticate_both!, only: [:index, :show]
  before_action :authenticate_headhunter!, only: [:new, :create, :edit, :update, :chance_status]
  before_action :authenticate_candidate!, only: [:search]
    
  def index
    @jobs = Job.where(headhunter_id: current_headhunter.id)
  end

  def show
    @job = Job.find(params[:id])
    @subscription = Subscription.find_by(job_id: @job, candidate_id: current_candidate) if current_candidate
    @propose = Propose.find_by(subscription_id: @subscription) if @subscription
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

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])

    if @job.update(params.require(:job).permit(:title, :job_description, :skills_description, :salary_min, :salary_max, :job_level, :subscription_date, :city))
      flash[:notice] = 'Vaga editada com sucesso!'
      redirect_to @job
    else
      render :edit
    end
  end

  def search
    if params[:q].length > 1
      @jobs = Job.where('title like ?', "%#{params[:q]}%").where(status: 'active')
      render :search

    else
      flash[:notice] = 'O valor da busca deve conter mais de 1 caracter'
      redirect_to root_path
    end
  end

  def chance_status
    @job = Job.find(params[:id])
    @job.update(status: :finished)
    redirect_to job_path(@job)
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
