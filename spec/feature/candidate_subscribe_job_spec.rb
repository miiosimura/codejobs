require 'rails_helper'

feature 'Candidate subscribe a job' do
  scenario 'successfully' do
    headhunter = Headhunter.create!(email: 'teste@email.com', password: '123456')
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    job = Job.create!(headhunter_id: headhunter.id, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: '2020-02-01', city: 'São Paulo', status: 'active')
    
    login_as(candidate, scope: :candidate)
    visit root_path
    fill_in 'Buscar Vagas', with: 'Ruby'
    click_on 'Buscar'

    click_on 'Desenvolvedor Ruby Junior'
    click_on 'Candidatar-se'
    fill_in 'Conte um pouco sobre você :)', with: 'Gosto de programar em Ruby'
    click_on 'Salvar inscrição'

    expect(current_path).to eq(subscriptions_path)
    expect(page).to have_content('Obrigada pela sua inscrição. Em breve o recrutador entrará em contato!')
    expect(page).to have_content('Minhas Inscrições')
    expect(page).to have_link('Desenvolvedor Ruby Junior')
    expect(page).to have_link('Voltar')  
  end

  scenario 'and is already subscribed' do
    headhunter = Headhunter.create!(email: 'teste@email.com', password: '123456')
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: '2020-02-01', city: 'São Paulo', status: 'active')
    subscription = Subscription.create!(job_id: job.id, candidate_id: candidate.id, about_candidate: 'Gosto de Programar')
    
    login_as(candidate, scope: :candidate)
    visit subscriptions_path
    click_on 'Desenvolvedor Ruby Junior'

    expect(page).to have_content('Aguardando o retorno do Recrutador')
    expect(page).to have_link('Voltar')
    expect(page).not_to have_link('Candidatar-se')
  end

  scenario 'and profile is not complete' do
    headhunter = Headhunter.create!(email: 'teste@email.com', password: '123456')
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456')
    job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: '2020-02-01', city: 'São Paulo', status: 'active')
    subscription = Subscription.create!(job_id: job.id, candidate_id: candidate.id, about_candidate: 'Gosto de Programar')
    
    login_as(candidate, scope: :candidate)
    visit root_path
    fill_in 'Buscar Vagas', with: 'Ruby'
    click_on 'Buscar'

    click_on 'Desenvolvedor Ruby Junior'
    click_on 'Candidatar-se'

    expect(current_path).to eq(edit_candidate_path(candidate))
  end
end