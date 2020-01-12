require 'rails_helper'

feature 'Headhunter set candidate as featured' do
  scenario 'successfully' do
    headhunter = Headhunter.create!(email: 'headhunter@email.com', password: '123456')
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: Date.today + 1.months, city: 'São Paulo', status: 'active')
    subscription = Subscription.create!(job_id: job.id, candidate_id: candidate.id, about_candidate: 'Gosto de Programar')
    
    login_as(headhunter, scope: :headhunter)
    visit root_path
    click_on 'Minhas Vagas'
    click_on job.title
    click_on 'Marcar como destaque'
    
    expect(current_path).to eq(job_path(job.id))
    expect(page).to have_link(candidate.name)
    expect(page).to have_content(subscription.about_candidate)
    expect(page).to have_link('Em destaque')
    expect(page).to have_link('Voltar')
  end

  scenario 'and headhunter can unset previously featured candidate' do
    headhunter = Headhunter.create!(email: 'headhunter@email.com', password: '123456')
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: Date.today + 1.months, city: 'São Paulo', status: 'active')
    subscription = Subscription.create!(featured_profile: true, job_id: job.id, candidate_id: candidate.id, about_candidate: 'Gosto de Programar')
    
    login_as(headhunter, scope: :headhunter)
    visit root_path
    click_on 'Minhas Vagas'
    click_on job.title
    click_on 'Em destaque'

    expect(current_path).to eq(job_path(job.id))
    expect(page).to have_link('Marcar como destaque')
    expect(page).to have_link('Voltar')
  end
end
