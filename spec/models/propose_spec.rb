require 'rails_helper'

RSpec.describe Propose, type: :model do
  describe '.verify_valid_start_date' do
    it 'success' do
      headhunter = Headhunter.create!(email: 'headhunter@email.com', password: '123456')
      candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
      job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: Date.today + 5, city: 'São Paulo', status: 'active')
      subscription = Subscription.create!(job_id: job.id, candidate_id: candidate.id, about_candidate: 'Gosto de Programar')
      propose = Propose.create!(subscription_id: subscription.id, start_date: Date.today + 2, salary: 3000.00, benefit: 'VT, VR', function: 'Desenvolvedor Junior', company_expectation: 'Ajudar na manutenção do site da empresa', bonus: 'Cafe a vontade')

      propose.verify_valid_start_date

      expect(propose.errors.empty?).to eq true
    end

    it 'start date less than or equal to today' do
      headhunter = Headhunter.create!(email: 'headhunter@email.com', password: '123456')
      candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
      job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: Date.today + 5, city: 'São Paulo', status: 'active')
      subscription = Subscription.create!(job_id: job.id, candidate_id: candidate.id, about_candidate: 'Gosto de Programar')
      propose = Propose.create(subscription_id: subscription.id, start_date: Date.yesterday, salary: 3000.00, benefit: 'VT, VR', function: 'Desenvolvedor Junior', company_expectation: 'Ajudar na manutenção do site da empresa', bonus: 'Cafe a vontade')

      expect(propose.errors.full_messages).to include 'Start date deve estar em um período de 3 meses, a partir de hoje'
    end

    it 'start date greater than 3 months' do
      headhunter = Headhunter.create!(email: 'headhunter@email.com', password: '123456')
      candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')
      job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: Date.today + 5, city: 'São Paulo', status: 'active')
      subscription = Subscription.create!(job_id: job.id, candidate_id: candidate.id, about_candidate: 'Gosto de Programar')
      propose = Propose.create(subscription_id: subscription.id, start_date: Date.today + 3.months, salary: 3000.00, benefit: 'VT, VR', function: 'Desenvolvedor Junior', company_expectation: 'Ajudar na manutenção do site da empresa', bonus: 'Cafe a vontade')

      expect(propose.errors.full_messages).to include 'Start date deve estar em um período de 3 meses, a partir de hoje'
    end
  end
end
