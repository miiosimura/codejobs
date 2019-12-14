class CandidatesController < ApplicationController
  def profile
    @candidate = current_candidate
  end
  
  def update_profile
    if current_candidate.update(params.permit(:name, :birthday, :scholarity, :work_experience, :job_interest))
      flash[:notice] = 'Parabéns! Agora você está pronto para se candidatar!'
      redirect_to root_path
    end
  end
end