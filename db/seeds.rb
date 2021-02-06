Headhunter.create!(email: 'hunter@email.com', password: '123456')

Headhunter.create!(email: 'hunter2@email.com', password: '123456')

Candidate.create!(email: 'candidate@email.com', password: '123456', name: 'John Doe', birthday: '1995-05-12',
                  scholarity: 'Superios completo', work_experience: 'Desenvolvedor Pleno na Empresa XPTO',
                  job_interest: 'Desenvolvedor Sênior')

Job.create!(headhunter_id: 1, title: 'Desenvolvedor Sênior', job_description: 'Vaga para Dev Sênior',
            skills_description: 'Ruby on Rails e TDD', salary_min: 8000.0, salary_max: 9000.0,
            job_level: 'Senior', subscription_date: (Date.today + 1.month), city: 'São Paulo')

Job.create!(headhunter_id: 2, title: 'Desenvolvedor Pleno', job_description: 'Vaga para Dev Pleno',
            skills_description: 'Javascript', salary_min: 8000.0, salary_max: 9000.0,
            job_level: 'Pleno', subscription_date: (Date.today + 1.month), city: 'São Paulo')

Subscription.create!(job_id: 1, candidate_id: 1, about_candidate: 'Acredito ser apto para essa vaga!')

Subscription.create!(job_id: 2, candidate_id: 1, about_candidate: 'Entendo de Javascript')

Message.create!(content: 'Olá! Vamos marcar uma entrevista amanhã às 10 da manhã?', candidate_id: 1,
                headhunter_id: 1, sent_by: 0)

Message.create!(content: 'Sim! Nos encontramos amanhã às 10hrs', candidate_id: 1,
                headhunter_id: 1, sent_by: 1)

Propose.create!(subscription_id: 1, start_date: Date.today + 1.week, salary: 8500.0, benefit: 'VR e VA',
                function: 'Dar manutenção no código', company_expectation: 'Entregar as demandas',
                bonus: 'Peru de Natal')