require 'rails_helper'

feature 'Headhunter send propose to Candidate' do
  scenario 'successfully' do
    headhunter = Headhunter.create!(email: 'headhunter@email.com', password: '123456')
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: '2020-01-01', city: 'São Paulo')
    subscription = Subscription.create!(job_id: job.id, candidate_id: candidate.id, about_candidate: 'Gosto de Programar')

    login_as(headhunter, scope: :headhunter)
    visit root_path
    click_on 'Minhas Vagas'
    click_on job.title
    click_on candidate.name
    click_on 'Enviar Proposta'
    fill_in 'Data de Inicio', with: '2020-02-02'
    fill_in 'Salario', with: 3000.00
    fill_in 'Beneficios', with: 'VT, VR'
    fill_in 'Função', with: 'Desenvolvedor Ruby'
    fill_in 'Expectativas da Empresa', with: 'Ajudar na manutenção do site da empresa'
    fill_in 'Bônus', with: 'Cafe a vontade'
    click_on 'Enviar'

    expect(current_path).to eq(candidate_path(candidate.id))
    expect(page).not_to have_link('Enviar Proposta')
    expect(page).to have_content('Sua proposta foi enviada! Aguarde o retorno do Candidato')
    expect(page).to have_link('Voltar')
  end

  scenario 'and Candidate accept propose' do
    
  end

  scenario 'and Candidate denial propose' do
    
  end
end