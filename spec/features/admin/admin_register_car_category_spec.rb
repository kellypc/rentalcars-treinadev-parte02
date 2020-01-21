require 'rails_helper'

feature 'Admin register car category' do
  scenario 'successfully' do
    user = create(:user, role: :admin)

    login_as user, scope: :user
    visit root_path
    click_on "Categorias de carro" 
    click_on "Registrar nova categoria"
    fill_in "Nome", with: "Categoria A"
    fill_in "Diária padrão", with: 50.00
    fill_in "Seguro padrão do carro", with: 25.00
    fill_in "Seguro padrão contra terceiros", with: 15.00
    click_on "Salvar"

    expect(page).to have_content("Dados salvos com sucesso")
    expect(page).to have_content("Nome: Categoria A")
    expect(page).to have_content("Diária: R$ 50,00")
    expect(page).to have_content("Seguro: R$ 25,00")
    expect(page).to have_content("Seguro de terceiros: R$ 15,00")
  end
end