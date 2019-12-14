require 'rails_helper'

feature 'Headhunter create account' do
  scenario 'successfully' do
    visit root_path
    click_on 'Sou Recrutador'
    click_on 'Cadastre-se'

    fill_in 'Email', with: 'email@teste.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar Senha', with: '123456'
    click_on 'Cadastrar'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).not_to have_link('Sou Recrutador')
    expect(page).not_to have_link('Sou Candidato')
    expect(page).to have_content('Sair')
  end

  scenario 'and email must be unique' do
    Headhunter.create!(email: 'email@email.com', password: '123456')
    
    visit root_path
    click_on 'Sou Recrutador'
    click_on 'Cadastre-se'

    fill_in 'Email', with: 'email@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar Senha', with: '123456'
    click_on 'Cadastrar'

    expect(current_path).to eq(headhunter_registration_path)
    expect(page).to have_content('1 error prohibited this headhunter from being saved:')
    expect(page).to have_content('Email has already been taken')
  end
end