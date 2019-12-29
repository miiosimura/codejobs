require 'rails_helper'

feature 'Candidate create profile' do
  scenario 'successfully' do
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456')
    
    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Ver Perfil'
    click_on 'Editar Perfil'
    
    fill_in 'Nome', with: 'Maria'
    fill_in 'Data de Nascimento', with: '01-01-1999'
    fill_in 'Escolaridade', with: 'Ensino Superior'
    fill_in 'Experiência Profissional', with: 'Empresa Fulano'
    fill_in 'Vagas de Interesse', with: 'Dev Junior'
    click_on 'Completar Perfil'
  
    expect(current_path).to eq(candidate_path(candidate))
    expect(page).to have_content('Maria')
    expect(page).to have_content('Email: candidate@email.com')
    expect(page).to have_content('Data de Nascimento: 1999-01-01')
    expect(page).to have_content('Escolaridade: Ensino Superior')
    expect(page).to have_content('Experiência Profissional: Empresa Fulano')
    expect(page).to have_content('Vagas de Interesse: Dev Junior')
  end

  scenario 'and birthday is not valid' do
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456')
    
    login_as(candidate, scope: :candidate)
    visit edit_candidate_path(candidate)
        
    fill_in 'Nome', with: 'Maria'
    fill_in 'Data de Nascimento', with: '01-01-1800'
    fill_in 'Escolaridade', with: 'Ensino Superior'
    fill_in 'Experiência Profissional', with: 'Empresa Fulano'
    fill_in 'Vagas de Interesse', with: 'Dev Junior'
    click_on 'Completar Perfil'
  
    expect(page).to have_content('Birthday inválida')
  end

  scenario 'and profile is complete' do
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456')
    
    login_as(candidate, scope: :candidate)
    visit root_path

    expect(page).to have_content('Complete seu perfil para começar a se candidatar :)')
  end

  scenario 'and profile is not complete' do
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: 1999-05-05, scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    
    login_as(candidate, scope: :candidate)
    visit root_path

    expect(page).to have_content('Você está pronto para se candidatar! :D')
  end
end

