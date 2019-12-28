require 'rails_helper'

feature 'Headhunter denial a subscription' do
  scenario 'successfully' do
    headhunter = Headhunter.create!(email: 'headhunter@email.com', password: '123456')
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: '2020-01-01', city: 'São Paulo', status: 'active')
    subscription = Subscription.create!(job_id: job.id, candidate_id: candidate.id, about_candidate: 'Gosto de Programar')

    login_as(headhunter, scope: :headhunter)
    visit root_path
    click_on 'Minhas Vagas'
    click_on job.title
    click_on candidate.name
    click_on 'Recusar Inscrição'
    fill_in 'Qual motivo da recusa?', with: 'Um dos requisitos da vaga não foi atendido'
    click_on 'Enviar'

    expect(current_path).to eq(job_path(job.id))
    expect(page).not_to have_link(candidate.name)
    expect(page).not_to have_content(subscription.about_candidate)
    expect(page).to have_link('Voltar')
  end

  scenario 'and candidate see feedback' do
    headhunter = Headhunter.create!(email: 'headhunter@email.com', password: '123456')
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: '2020-01-01', city: 'São Paulo', status: 'active')
    subscription = Subscription.create!(job_id: job.id, candidate_id: candidate.id, about_candidate: 'Gosto de Programar', denial_reason: 'Um dos requisitos da vaga não foi atendido')

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Minhas Inscrições'
    click_on job.title
    
    expect(page).not_to have_content('Você ja se candidatou. Aguarde o retorno do Recrutador')
    expect(page).to have_content('Resposta do Recrutador')
    expect(page).to have_content(subscription.denial_reason)
  end
end