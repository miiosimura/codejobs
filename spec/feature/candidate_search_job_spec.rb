require 'rails_helper'

feature 'Candidate search a job' do
  scenario 'successfully' do
    headhunter = Headhunter.create!(email: 'teste@email.com', password: '123456')
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: '2020-01-01', city: 'São Paulo', status: 'active')
    other_job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Java', job_description: 'Descrição da vaga aqui', skills_description: 'Java', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Senior', subscription_date: '2020-01-01', city: 'São Paulo', status: 'active')
    
    login_as(candidate, scope: :candidate)
    visit root_path
    
    fill_in 'Buscar Vagas', with: 'Ruby'
    click_on 'Buscar'
  
    expect(page).to have_link(job.title)
    expect(page).not_to have_link(other_job.title)
  end

  scenario 'and candidate does not find finished jobs in search' do
    headhunter = Headhunter.create!(email: 'headhunter@email.com', password: '123456')
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    job = Job.create!(headhunter_id: headhunter.id, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: '2020-01-01', city: 'São Paulo', status: 'finished')
    other_job = Job.create!(headhunter_id: headhunter.id, title: 'Desenvolvedor Ruby Fullstack', job_description: 'Outra descrição', skills_description: 'Saber Front e Back usando Ruby', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Pleno', subscription_date: '2020-01-01', city: 'São Paulo', status: 'active')

    login_as(candidate, scope: :candidate)
    visit root_path
    fill_in 'Buscar Vagas', with: 'Ruby'
    click_on 'Buscar'
    
    expect(page).not_to have_link(job.title)
    expect(page).to have_link(other_job.title)
  end
end