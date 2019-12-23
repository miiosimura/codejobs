require 'rails_helper'

feature 'Headhunter list his job subscriptions' do
  scenario 'successfully' do
    headhunter = Headhunter.create!(email: 'headhunter@email.com', password: '123456')
    job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: '2020-01-01', city: 'São Paulo')
    other_job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Java', job_description: 'Descrição da vaga aqui', skills_description: 'Java', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Senior', subscription_date: '2020-01-01', city: 'São Paulo')
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    other_candidate = Candidate.create!(email: 'other.candidate@email.com', password: '123456', name: 'Mary', birthday: '1996-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    another_candidate = Candidate.create!(email: 'another.candidate@email.com', password: '123456', name: 'James', birthday: '1996-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    subscription = Subscription.create!(job_id: job.id, candidate_id: candidate.id, about_candidate: 'Gosto de Programar')
    other_subscription = Subscription.create!(job_id: job.id, candidate_id: other_candidate.id, about_candidate: 'Sou muito inteliegente')
    another_subscription = Subscription.create!(job_id: other_job.id, candidate_id: another_candidate.id, about_candidate: 'Sou muito atencioso')

    login_as(headhunter, scope: :headhunter)
    visit root_path
    click_on 'Minhas Vagas'
    click_on 'Desenvolvedor Ruby Junior'

    expect(page).to have_content(job.title)
    expect(page).to have_content('Inscritos na vaga')
    expect(page).to have_link(candidate.name)
    expect(page).to have_content(subscription.about_candidate)
    expect(page).to have_link(other_candidate.name)
    expect(page).to have_content(other_subscription.about_candidate)
    expect(page).not_to have_link(another_candidate.name)
    expect(page).not_to have_content(another_subscription.about_candidate)
    expect(page).to have_link('Voltar')
  end

  scenario 'and is able to see the candidate details' do
    headhunter = Headhunter.create!(email: 'headhunter@email.com', password: '123456')
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: '2020-01-01', city: 'São Paulo')
    subscription = Subscription.create!(job_id: job.id, candidate_id: candidate.id, about_candidate: 'Gosto de Programar')
    
    login_as(headhunter, scope: :headhunter)
    visit jobs_path
    click_on 'Desenvolvedor Ruby Junior'
    click_on candidate.name

    expect(current_path).to eq(candidate_path(candidate.id))
    expect(page).to have_content(candidate.name)
    expect(page).to have_content(candidate.email)
    expect(page).to have_content(candidate.birthday)
    expect(page).to have_content(candidate.scholarity)
    expect(page).to have_content(candidate.work_experience)
    expect(page).to have_content(candidate.job_interest)
    expect(page).to have_link('Voltar')
  end
end
