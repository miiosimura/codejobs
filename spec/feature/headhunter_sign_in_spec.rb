require 'rails_helper'

feature 'Headhunter sign in' do
  scenario 'successfully' do
    Headhunter.create!(email: 'headhunter@email.com', password: '123456')
    
    visit root_path
    click_on 'Sou Recrutador'
    
    fill_in 'Email', with: 'headhunter@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Log in'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Signed in successfully')
    expect(page).to have_link('Sair')
    expect(page).not_to have_link('Sou Recrutador')
    expect(page).not_to have_link('Sou Candidato')
  end

  scenario 'and must fill all fields' do
    Headhunter.create!(email: 'headhunter@email.com', password: '123456')
    
    visit root_path
    click_on 'Sou Recrutador'
    
    fill_in 'Email', with: ''
    fill_in 'Senha', with: ''
    click_on 'Log in'

    expect(current_path).to eq(headhunter_session_path)
    expect(page).to have_content('Invalid Email or password.')
  end

  scenario 'and email cant be blank' do
    Headhunter.create!(email: 'headhunter@email.com', password: '123456')
    
    visit root_path
    click_on 'Sou Recrutador'
    
    fill_in 'Email', with: ''
    fill_in 'Senha', with: '123456'
    click_on 'Log in'

    expect(current_path).to eq(headhunter_session_path)
    expect(page).to have_content('Invalid Email or password.')
  end

  scenario 'and password cant be blank' do
    Headhunter.create!(email: 'headhunter@email.com', password: '123456')
    
    visit root_path
    click_on 'Sou Recrutador'
    
    fill_in 'Email', with: 'candidate@email.com'
    fill_in 'Senha', with: ''
    click_on 'Log in'

    expect(current_path).to eq(headhunter_session_path)
    expect(page).to have_content('Invalid Email or password.')
  end

  scenario 'and log out' do
    headhunter = Headhunter.create!(email: 'headhunter@email.com', password: '123456')

    login_as(headhunter, scope: :headhunter)
    visit root_path
    click_on 'Sair'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Signed out successfully')
    expect(page).to have_link('Sou Recrutador')
    expect(page).to have_link('Sou Candidato')
    expect(page).not_to have_link('Sair')
  end
end