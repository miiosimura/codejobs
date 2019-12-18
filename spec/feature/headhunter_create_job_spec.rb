require 'rails_helper'

feature 'Headhunter create a job' do
  scenario 'successfully' do
    headhunter = Headhunter.create!(email: 'email@email.com', password: '123456')
    
    login_as(headhunter, scope: :headhunter)
    visit root_path
    click_on 'Cadastrar Vaga'

    fill_in 'Titulo da vaga', with: 'Desenvolvedor(a) Ruby'
    fill_in 'Descrição', with: 'Estamos precisando de um desenvolvedor com expericência em Ruby e Ruby on Rails'
    fill_in 'Habilidades desejadas', with: 'Ruby, Ruby on Rails, HTML, Bootstrap'
    fill_in 'Faixa Salarial de', with: '3000'
    fill_in 'até', with: '4000'
    select 'Junior', from: 'Nível da vaga'
    fill_in 'Data limite para inscrições', with: '2020-01-25'
    fill_in 'Região do local de Trabalho', with: 'Paulista'
    click_on 'Cadastrar'

    expect(page).to have_content('Nova vaga cadastrada com sucesso!')
    expect(page).to have_content('Desenvolvedor(a) Ruby')
    expect(page).to have_content('Descrição: Estamos precisando de um desenvolvedor com expericência em Ruby e Ruby on Rails')
    expect(page).to have_content('Habilidades desejadas: Ruby, Ruby on Rails, HTML, Bootstrap')
    expect(page).to have_content('Faixa Salarial: De R$ 3000.0 até R$ 4000.0')
    expect(page).to have_content('Nivel: Junior')
    expect(page).to have_content('Data limite para inscrições: 2020-01-25')
    expect(page).to have_content('Local de Trabalho: Paulista')
    expect(page).to have_link('Voltar')
  end

  #TODO fazer teste que verifica data e faixa de salarios
end