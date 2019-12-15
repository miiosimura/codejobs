require 'rails_helper'

feature 'Candidate create profile' do
  scenario 'successfully' do
    candidate = Candidate.create!(email: 'email@email.com', password: '123456')
    
    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Perfil'
    
    fill_in 'Nome', with: 'Maria'
    fill_in 'Data de Nascimento', with: '01-01-1999'
    fill_in 'Escolaridade', with: 'Ensino Superior'
    fill_in 'Experiência Profissional', with: 'Empresa Fulano'
    fill_in 'Vagas de Interesse', with: 'Dev Junior'
    click_on 'Completar Perfil'
  
    expect(current_path).to eq(root_path)
    expect(page).to have_content('Oba! Você está pronto para se candidatar! :D')
  end

  scenario 'and birthday is not valid' do
    candidate = Candidate.create!(email: 'email@email.com', password: '123456')
    
    login_as(candidate, scope: :candidate)
    visit edit_candidate_path(candidate)
        
    fill_in 'Nome', with: 'Maria'
    fill_in 'Data de Nascimento', with: '01-01-1800'
    fill_in 'Escolaridade', with: 'Ensino Superior'
    fill_in 'Experiência Profissional', with: 'Empresa Fulano'
    fill_in 'Vagas de Interesse', with: 'Dev Junior'
    click_on 'Completar Perfil'
  
    expect(current_path).to eq(edit_candidate_path(current_candidate))
    expect(page).to have_content('Birthdat inválida')
  end
end

