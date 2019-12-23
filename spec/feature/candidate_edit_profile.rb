require 'rails_helper'

feature 'Candidate edit profile' do
  scenario 'and leaves field blank' do
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: 1999-05-05, scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
        
    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Perfil'
    
    fill_in 'Nome', with: ''
    click_on 'Completar Perfil'
  
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Complete seu perfil para começar a se candidatar :)')
  end
end

