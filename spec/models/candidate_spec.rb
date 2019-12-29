require 'rails_helper'

RSpec.describe Candidate, type: :model do
  describe '.verified_profile?' do
    it 'success' do
      candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')

      candidate = candidate.verified_profile?

      expect(candidate).to eq true
    end

    it 'profile is empty' do
      candidate = Candidate.create!(email: 'candidate@email.com', password: '123456')

      candidate = candidate.verified_profile?

      expect(candidate).to eq false
    end

    it 'one profile field is empty' do
      candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: '')

      candidate = candidate.verified_profile?

      expect(candidate).to eq false
    end
  end

  describe '.verify_valid_birthday' do
    it 'success' do
      candidate = Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1999-05-05', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')

      candidate.verify_valid_birthday

      expect(candidate.errors.empty?).to eq true
    end

    it 'invalid birthday' do
      candidate = Candidate.create(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '1899-01-01', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')

      candidate.verify_valid_birthday

      expect(candidate.errors.full_messages).to include 'Birthday inválida'
    end

    it 'is under age' do
      candidate = Candidate.create(email: 'candidate@email.com', password: '123456', name: 'Maria', birthday: '2017-01-01', scholarity: 'Tecnologo', work_experience: 'Empresa X', job_interest: 'Dev Junior')

      candidate.verify_valid_birthday

      expect(candidate.errors.full_messages).to include 'Birthday inválida'
    end
  end
end
