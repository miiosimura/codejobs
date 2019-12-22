require 'rails_helper'

feature 'Headhunter and candidate cann comment profile' do
  scenario 'headhunter can comment successfully' do
    headhunter = Headhunter.create!(email: 'email@email.com', password: '123456')
    candidate = Candidate.create!(email: 'email@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: '2020-01-01', city: 'São Paulo')
    subscription = Subscription.create!(job_id: job.id, candidate_id: candidate.id, about_candidate: 'Gosto de Programar')
    
    login_as(headhunter, scope: :headhunter)
    visit root_path
    click_on 'Minhas Vagas'
    click_on job.title
    click_on candidate.name
    fill_in 'Mande uma mensagem', with: 'Voce tem disponibilidade para vir fazer uma entrevista sexta-feira as 18 horas?'
    click_on 'Enviar'

    expect(current_path).to eq(candidate_path(candidate.id))
    expect(page).to have_content(candidate.name)
    expect(page).to have_content(candidate.email)
    expect(page).to have_content(candidate.birthday)
    expect(page).to have_content(candidate.scholarity)
    expect(page).to have_content(candidate.work_experience)
    expect(page).to have_content(candidate.job_interest)
    expect(page).to have_content(headhunter.email)
    expect(page).to have_content('Voce tem disponibilidade para vir fazer uma entrevista sexta-feira as 18 horas?')
    expect(page).to have_content(Message.last.created_at)
    expect(page).to have_link('Voltar')
  end

  scenario 'and candidate can respond' do
    headhunter = Headhunter.create!(email: 'email@email.com', password: '123456')
    candidate = Candidate.create!(email: 'email@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: '2020-01-01', city: 'São Paulo')
    subscription = Subscription.create!(job_id: job.id, candidate_id: candidate.id, about_candidate: 'Gosto de Programar')
    Message.create!(message_content: 'Voce tem disponibilidade para vir fazer uma entrevista sexta-feira as 18 horas?', profile_id: candidate.id,  headhunter_id: headhunter_id.id, sent_by: 'headhunter')
    
    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Minhas mensagens'
    fill_in 'message_content', with: 'Tenho sim'
    click_on 'Enviar'

    expect(current_path).to eq(candidate_path(candidate.id))
    expect(page).to have_content('Voce tem disponibilidade para vir fazer uma entrevista sexta-feira as 18 horas?')
    expect(page).to have_content('Tenho sim')
    expect(page).to have_link('Voltar')
  end

  scenario 'and the commentaries are still visible' do
    headhunter = Headhunter.create!(email: 'email@email.com', password: '123456')
    candidate = Candidate.create!(email: 'email@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
    job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: '2020-01-01', city: 'São Paulo')
    subscription = Subscription.create!(job_id: job.id, candidate_id: candidate.id, about_candidate: 'Gosto de Programar')
    Message.create!(message_content: 'Voce tem disponibilidade para vir fazer uma entrevista sexta-feira as 18 horas?', profile_id: candidate.id,  headhunter_id: headhunter_id.id, sent_by: 'headhunter')
    Message.create!(message_content: 'Tenho sim', profile_id: candidate.id,  headhunter_id: headhunter_id.id, sent_by: 'candidate')
    Message.create!(message_content: 'Certo, o endereço é: Rua XPTO, numero 1234', profile_id: candidate.id,  headhunter_id: headhunter_id.id, sent_by: 'headhunter')
    
    login_as(headhunter, scope: :headhunter)
    visit jobs_path
    click_on job.title
    click_on candidate.name

    expect(page).to have_content('Voce tem disponibilidade para vir fazer uma entrevista sexta-feira as 18 horas?')
    expect(page).to have_content('Tenho sim')
    expect(page).to have_content('Certo, o endereço é: Rua XPTO, numero 1234')
    expect(page).to have_link('Voltar')
  end
end
