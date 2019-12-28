require 'rails_helper'

feature 'Headhunter and candidate can comment profile' do
  scenario 'headhunter can comment successfully' do
    headhunter = Headhunter.create!(email: 'headhunter@email.com', password: '123456')
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: '2020-01-01', city: 'São Paulo')
    subscription = Subscription.create!(job_id: job.id, candidate_id: candidate.id, about_candidate: 'Gosto de Programar')
    
    login_as(headhunter, scope: :headhunter)
    visit root_path
    click_on 'Minhas Vagas'
    click_on job.title
    click_on candidate.name
    click_on 'Enviar Mensagem'
    fill_in 'Mande uma mensagem', with: 'Voce tem disponibilidade para vir fazer uma entrevista sexta-feira as 18 horas?'
    click_on 'Enviar'

    expect(page).to have_content('Mensagens')
    expect(page).to have_content("Enviado por: #{headhunter.email}")
    expect(page).to have_content('Mensagem: Voce tem disponibilidade para vir fazer uma entrevista sexta-feira as 18 horas?')
    expect(page).to have_content("Criado em: #{Message.last.created_at}")
    expect(page).to have_link('Enviar Nova Mensagem')
    expect(page).to have_link('Voltar')
  end

  scenario 'and candidate can respond' do
    headhunter = Headhunter.create!(email: 'headhunter@email.com', password: '123456')
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: '2020-01-01', city: 'São Paulo')
    subscription = Subscription.create!(job_id: job.id, candidate_id: candidate.id, about_candidate: 'Gosto de Programar')
    message = Message.create!(content: 'Voce tem disponibilidade para vir fazer uma entrevista sexta-feira as 18 horas?', candidate_id: candidate.id,  headhunter_id: headhunter.id, sent_by: 'headhunter')
    
    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Minhas Mensagens'
    click_on 'headhunter@email.com'
    click_on 'Enviar Nova Mensagem'
    fill_in 'Mande uma mensagem', with: 'Tenho sim'
    click_on 'Enviar'

    expect(page).to have_content("Enviado por: #{candidate.email}")
    expect(page).to have_content('Mensagem: Tenho sim')
    expect(page).to have_content("Criado em: #{Message.last.created_at}")
    expect(page).to have_link('Enviar Nova Mensagem')
    expect(page).to have_link('Voltar')
  end

  scenario 'and the commentaries are still visible' do
    headhunter = Headhunter.create!(email: 'headhunter@email.com', password: '123456')
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: '2020-01-01', city: 'São Paulo')
    subscription = Subscription.create!(job_id: job.id, candidate_id: candidate.id, about_candidate: 'Gosto de Programar')
    Message.create!(content: 'Voce tem disponibilidade para vir fazer uma entrevista sexta-feira as 18 horas?', candidate_id: candidate.id,  headhunter_id: headhunter.id, sent_by: 'headhunter')
    Message.create!(content: 'Tenho sim', candidate_id: candidate.id,  headhunter_id: headhunter.id, sent_by: 'candidate')
    Message.create!(content: 'Certo, o endereço é: Rua XPTO, numero 1234', candidate_id: candidate.id,  headhunter_id: headhunter.id, sent_by: 'headhunter')
    
    login_as(headhunter, scope: :headhunter)
    visit root_path
    click_on 'Minhas Mensagens'
    click_on candidate.email

    expect(page).to have_content('Voce tem disponibilidade para vir fazer uma entrevista sexta-feira as 18 horas?')
    expect(page).to have_content('Tenho sim')
    expect(page).to have_content('Certo, o endereço é: Rua XPTO, numero 1234')
  end

  scenario 'and Headhunter send empty message' do
    headhunter = Headhunter.create!(email: 'headhunter@email.com', password: '123456')
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: '2020-01-01', city: 'São Paulo')
    subscription = Subscription.create!(job_id: job.id, candidate_id: candidate.id, about_candidate: 'Gosto de Programar')
    
    login_as(headhunter, scope: :headhunter)
    visit new_candidate_messages_path(candidate_id: candidate.id)
    click_on 'Enviar'

    expect(page).to have_content('Content não pode ser em branco')
  end

  scenario 'and Headhunter send empty message' do
    headhunter = Headhunter.create!(email: 'headhunter@email.com', password: '123456')
    candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: '2020-01-01', city: 'São Paulo')
    subscription = Subscription.create!(job_id: job.id, candidate_id: candidate.id, about_candidate: 'Gosto de Programar')
    
    login_as(candidate, scope: :candidate)
    visit new_headhunter_messages_path(headhunter_id: headhunter.id)
    click_on 'Enviar'

    expect(page).to have_content('Content não pode ser em branco')
  end
end
