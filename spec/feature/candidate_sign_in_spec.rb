require 'rails_helper'

feature 'Candidate sign in' do
  scenario 'successfully' do
    Candidate.create!(email: 'email@email.com', password: '123456')
    
    visit root_path
    click_on 'Sou Candidato'
    
    fill_in 'Email', with: 'email@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Log in'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Signed in successfully')
    expect(page).to have_link('Sair')
    expect(page).not_to have_link('Sou Recrutador')
    expect(page).not_to have_link('Sou Candidato')
  end

  scenario 'and must fill all fields' do
    Candidate.create!(email: 'email@email.com', password: '123456')
        
    visit root_path
    click_on 'Sou Candidato'
    
    fill_in 'Email', with: ''
    fill_in 'Senha', with: ''
    click_on 'Log in'

    expect(current_path).to eq(candidate_session_path)
    expect(page).to have_content('Invalid Email or password.')
  end

  scenario 'and email cant be blank' do
    Candidate.create!(email: 'email@email.com', password: '123456')
        
    visit root_path
    click_on 'Sou Candidato'
    
    fill_in 'Email', with: ''
    fill_in 'Senha', with: '123456'
    click_on 'Log in'

    expect(current_path).to eq(candidate_session_path)
    expect(page).to have_content('Invalid Email or password.')
  end

  scenario 'and password cant be blank' do
    Candidate.create!(email: 'email@email.com', password: '123456')
        
    visit root_path
    click_on 'Sou Candidato'
    
    fill_in 'Email', with: 'email@email.com'
    fill_in 'Senha', with: ''
    click_on 'Log in'

    expect(current_path).to eq(candidate_session_path)
    expect(page).to have_content('Invalid Email or password.')
  end

  scenario 'and log out' do
    candidate = Candidate.create!(email: 'email@email.com', password: '123456')

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Sair'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Signed out successfully')
    expect(page).to have_link('Sou Recrutador')
    expect(page).to have_link('Sou Candidato')
    expect(page).not_to have_link('Sair')
  end
end