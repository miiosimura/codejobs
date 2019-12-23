require 'rails_helper'

feature 'Candidate create account' do
  scenario 'successfully' do
    visit root_path
    click_on 'Sou Candidato'
    click_on 'Cadastre-se'

    fill_in 'Email', with: 'candidate@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar Senha', with: '123456'
    click_on 'Cadastrar'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Bem vindo! Sua conta foi criada com sucesso.')
    expect(page).to have_content('Complete seu perfil para começar a se candidatar :)')
    expect(page).not_to have_link('Sou Recrutador')
    expect(page).not_to have_link('Sou Candidato')
    expect(page).to have_content('Sair')
  end
  
  scenario 'and email must be unique' do
    Candidate.create!(email: 'candidate@email.com', password: '123456')
    
    visit root_path
    click_on 'Sou Candidato'
    click_on 'Cadastre-se'

    fill_in 'Email', with: 'candidate@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar Senha', with: '123456'
    click_on 'Cadastrar'

    expect(current_path).to eq(candidate_registration_path)
    expect(page).to have_content('1 error prohibited this candidate from being saved:')
    expect(page).to have_content('Email has already been taken')
  end
end