class CandidatesController < ApplicationController
  def edit
    @candidate = current_candidate
  end
  
  def update
    if current_candidate.update(params.require(:candidate).permit(:name, :birthday, :scholarity, :work_experience, :job_interest))
      redirect_to root_path
    else
      @candidate = current_candidate
      render :edit
    end
  end
end
