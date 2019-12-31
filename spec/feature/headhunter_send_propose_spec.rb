require 'rails_helper'

feature 'Headhunter send propose to Candidate' do
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

  scenario 'and Candidate see propose' do
    headhunter = Headhunter.create!(email: 'headhunter@email.com', password: '123456')
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: '2020-01-01', city: 'São Paulo', status: 'active')
    subscription = Subscription.create!(job_id: job.id, candidate_id: candidate.id, about_candidate: 'Gosto de Programar')
    propose = Propose.create!(subscription_id: subscription.id, start_date: '2020-02-02', salary: 3000.00, benefit: 'VT, VR', function: 'Desenvolvedor Junior', company_expectation: 'Ajudar na manutenção do site da empresa', bonus: 'Cafe a vontade')

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Minhas Inscrições'
    click_on job.title
    click_on 'Ver Proposta'

    expect(page).to have_content("Data de Inicio: #{propose.start_date}")
    expect(page).to have_content("Salario: #{propose.salary}")
    expect(page).to have_content("Beneficios: #{propose.benefit}")
    expect(page).to have_content("Função: #{propose.function}")
    expect(page).to have_content("Expectativas da Empresa: #{propose.company_expectation}")
    expect(page).to have_content("Bônus: #{propose.bonus}")
    expect(page).to have_link('Aceitar Proposta')
    expect(page).to have_link('Recusar Proposta')
  end

  scenario 'and Candidate accept propose' do
    headhunter = Headhunter.create!(email: 'headhunter@email.com', password: '123456')
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: '2020-01-01', city: 'São Paulo', status: 'active')
    subscription = Subscription.create!(job_id: job.id, candidate_id: candidate.id, about_candidate: 'Gosto de Programar')
    propose = Propose.create!(subscription_id: subscription.id, start_date: '2020-02-02', salary: 3000.00, benefit: 'VT, VR', function: 'Desenvolvedor Junior', company_expectation: 'Ajudar na manutenção do site da empresa', bonus: 'Cafe a vontade')
    
    login_as(candidate, scope: :candidate)
    visit subscriptions_path
    click_on job.title
    click_on 'Ver Proposta'
    click_on 'Aceitar Proposta'

    expect(current_path).to eq(job_path(job.id))
    expect(page).to have_content('Status da Inscrição')
    expect(page).to have_content('Você aceitou a Proposta! Parabéns pela nova contratação')
    expect(page).not_to have_link('Ver Proposta')
  end

  scenario 'and Candidate deny propose' do
    headhunter = Headhunter.create!(email: 'headhunter@email.com', password: '123456')
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: '2020-01-01', city: 'São Paulo', status: 'active')
    subscription = Subscription.create!(job_id: job.id, candidate_id: candidate.id, about_candidate: 'Gosto de Programar')
    propose = Propose.create!(subscription_id: subscription.id, start_date: '2020-02-02', salary: 3000.00, benefit: 'VT, VR', function: 'Desenvolvedor Junior', company_expectation: 'Ajudar na manutenção do site da empresa', bonus: 'Cafe a vontade')
    
    login_as(candidate, scope: :candidate)
    visit subscriptions_path
    click_on job.title
    click_on 'Ver Proposta'
    click_on 'Recusar Proposta'
    fill_in 'Qual motivo da recusa?', with: 'Salario imcompativel'
    click_on 'Enviar'

    expect(current_path).to eq(job_path(job.id))
    expect(page).to have_content('Status da Inscrição')
    expect(page).to have_content('Você recusou a Proposta')
    expect(page).not_to have_link('Ver Proposta')
  end

  scenario 'and Headhunter see his propose accepted' do
    headhunter = Headhunter.create!(email: 'headhunter@email.com', password: '123456')
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: '2020-01-01', city: 'São Paulo', status: 'active')
    subscription = Subscription.create!(job_id: job.id, candidate_id: candidate.id, about_candidate: 'Gosto de Programar')
    propose = Propose.create!(subscription_id: subscription.id, start_date: '2020-02-02', salary: 3000.00, benefit: 'VT, VR', function: 'Desenvolvedor Junior', company_expectation: 'Ajudar na manutenção do site da empresa', bonus: 'Cafe a vontade', accepted: true)

    login_as(headhunter, scope: :headhunter)
    visit jobs_path
    click_on job.title
    click_on candidate.name

    expect(page).not_to have_content('Sua proposta foi enviada! Aguarde o retorno do Candidato')
    expect(page).to have_content('O Candidato aceitou sua proposta!')
  end

  scenario 'and Headhunter see his propose declined' do
    headhunter = Headhunter.create!(email: 'headhunter@email.com', password: '123456')
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: '2020-01-01', city: 'São Paulo', status: 'active')
    subscription = Subscription.create!(job_id: job.id, candidate_id: candidate.id, about_candidate: 'Gosto de Programar')
    propose = Propose.create!(subscription_id: subscription.id, start_date: '2020-02-02', salary: 3000.00, benefit: 'VT, VR', function: 'Desenvolvedor Junior', company_expectation: 'Ajudar na manutenção do site da empresa', bonus: 'Cafe a vontade', accepted: false, denial_reason: 'Salario imcompativel')
  
    login_as(headhunter, scope: :headhunter)
    visit jobs_path
    click_on job.title
    click_on candidate.name

    expect(page).not_to have_content('Sua proposta foi enviada! Aguarde o retorno do Candidato')
    expect(page).to have_content('O Candidato recusou sua proposta')
    expect(page).to have_content("Motivo: #{propose.denial_reason}")
  end

  scenario 'and insert a start date less than or equal to today' do
    headhunter = Headhunter.create!(email: 'headhunter@email.com', password: '123456')
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: '2020-01-01', city: 'São Paulo', status: 'active')
    subscription = Subscription.create!(job_id: job.id, candidate_id: candidate.id, about_candidate: 'Gosto de Programar')

    login_as(headhunter, scope: :headhunter)
    visit root_path
    click_on 'Minhas Vagas'
    click_on job.title
    click_on candidate.name
    click_on 'Enviar Proposta'
    fill_in 'Data de Inicio', with: Date.yesterday
    fill_in 'Salario', with: 3000.00
    fill_in 'Beneficios', with: 'VT, VR'
    fill_in 'Função', with: 'Desenvolvedor Ruby'
    fill_in 'Expectativas da Empresa', with: 'Ajudar na manutenção do site da empresa'
    fill_in 'Bônus', with: 'Cafe a vontade'
    click_on 'Enviar'

    expect(page).to have_content('Start date deve estar em um período de 3 meses, a partir de hoje')
  end

  scenario 'and insert a start date greater than 3 months' do
    headhunter = Headhunter.create!(email: 'headhunter@email.com', password: '123456')
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: '2020-01-01', city: 'São Paulo', status: 'active')
    subscription = Subscription.create!(job_id: job.id, candidate_id: candidate.id, about_candidate: 'Gosto de Programar')

    login_as(headhunter, scope: :headhunter)
    visit root_path
    click_on 'Minhas Vagas'
    click_on job.title
    click_on candidate.name
    click_on 'Enviar Proposta'
    fill_in 'Data de Inicio', with: Date.today + 3.months
    fill_in 'Salario', with: 3000.00
    fill_in 'Beneficios', with: 'VT, VR'
    fill_in 'Função', with: 'Desenvolvedor Ruby'
    fill_in 'Expectativas da Empresa', with: 'Ajudar na manutenção do site da empresa'
    fill_in 'Bônus', with: 'Cafe a vontade'
    click_on 'Enviar'

    expect(page).to have_content('Start date deve estar em um período de 3 meses, a partir de hoje')
  end
  

end