require 'rails_helper'

feature 'Candidate subscribe a job' do
  scenario 'successfully' do
    headhunter = Headhunter.create!(email: 'teste@email.com', password: '123456')
    candidate = Candidate.create!(email: 'email@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: '2020-02-01', city: 'São Paulo')
    
    login_as(candidate, scope: :candidate)
    visit root_path
    fill_in 'Bora se candidatar?', with: 'Ruby'
    click_on 'Buscar Vagas'
    click_on 'Desenvolvedor Ruby Junior'
    click_on 'Candidatar-se'
    fill_in 'Conte um pouco sobre você :)', with: 'Gosto de programar em Ruby'
    click_on 'Salvar inscrição'

    expect(current_path).to eq(subscription_path)
    expect(page).to have_content('Minhas Vagas')
    expect(page).to have_link('Desenvolvedor Ruby Junior')
    expect(page).to have_link('Voltar')  
  end
end