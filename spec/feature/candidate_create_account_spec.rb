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

  scenario ', is not logged in and wants to access Profile' do
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456')

    visit candidate_path(candidate.id)

    expect(page).to have_content('Para essa ação, é necessário estar logado')
  end

  scenario ', is not logged in and wants to access Edit Profile' do
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456')

    visit edit_candidate_path(candidate.id)

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end