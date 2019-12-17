class JobsController < ApplicationController
  def show

  end

  def new
    @jobs = Job.new()
  end
  
  def create
    @job = Job.new(job_params)
    @job.headhunter_id = current_headhunter.id
    #if @job.save...
  end
end