# Codejobs

O Codejobs é um projeto feito durante o programa TreinaDev da Campus Code. Consiste em um site de oferta de empregos, que pode ser acessado tanto como candidato como recrutador.

Os candidatos podem se candidatar a vagas, buscar vagas e receber mensagens de recrutadores.

Os recrutadores podem cadastrar novas vagas, encerrar vagas, entrar em contato com os candidatos e marcar entrevistas.

# Subindo o projeto

1. `git clone https://github.com/miiosimura/codejobs.git`
2. A versão do ruby usada no projeto é a 2.6.3, lembre-se de trocar a versão ou instalar
3. `bundle install`
4. `rails db:migrate`
5. `rails db:seed`
6. `rails s` e acesse `http://localhost:3000/`
7. Para logar como candidato (Login: **candidate@email.com**, Senha: **123456**)
8. Para logar como recrutador (Login: **hunter@email.com**, Senha: **123456**)

# Rodando os testes

1. `rails db:migrate RAILS_ENV=test`
2. A cobertura de teste é feita com o SimpleCov. Para gerar o relatório, primeiramente é preciso rodar `coverage=on rspec .`
3. Com isso será possível acessar a interface do SimpleCov, rodando `open coverage/index.html` (para Mac) ou `xdg-open coverage/index.html` (para Debian/Ubuntu).