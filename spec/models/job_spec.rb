require 'rails_helper'

RSpec.describe Job, type: :model do
  describe '.verify_valid_subscription_date' do
    it 'success' do
      headhunter = Headhunter.create!(email: 'teste@email.com', password: '123456')
      job = Job.create!(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: Date.today + 1, city: 'São Paulo', status: 'active')

      job.verify_valid_subscription_date

      expect(job.errors.empty?).to eq true
    end

    it 'invalid' do
      headhunter = Headhunter.create!(email: 'teste@email.com', password: '123456')
      job = Job.create(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: Date.today - 1, city: 'São Paulo', status: 'active')

      job.verify_valid_subscription_date

      expect(job.errors.full_messages).to include 'Subscription date inválida'
    end
  end

  describe '.verify_salary_min_max' do
    it 'success' do
      headhunter = Headhunter.create!(email: 'teste@email.com', password: '123456')
      job = Job.create(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 2000.0, salary_max: 3000.0, job_level: 'Junior', subscription_date: Date.today + 1, city: 'São Paulo', status: 'active')

      job.verify_salary_min_max

      expect(job.errors.empty?).to eq true
    end

    it 'invalid' do
      headhunter = Headhunter.create!(email: 'teste@email.com', password: '123456')
      job = Job.create(headhunter_id: 1, title: 'Desenvolvedor Ruby Junior', job_description: 'Descrição da vaga aqui', skills_description: 'Ruby, Ruby on Rails', salary_min: 3000.0, salary_max: 2000.0, job_level: 'Junior', subscription_date: Date.today + 1, city: 'São Paulo', status: 'active')

      job.verify_salary_min_max

      expect(job.errors.full_messages).to include 'Salary max deve ser maior que Salary min'
    end
  end
end
