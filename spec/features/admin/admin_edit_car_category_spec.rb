require 'rails_helper'

feature 'Admin edit car category' do
  scenario 'successfully' do
    user = create(:user, role: :admin)
    Category.create!(name: "A", daily_rate: 50.00, car_insurance: 25.00,
                 third_party_insurance: 15.00)

    login_as user, scope: :user

    visit root_path
    click_on "Categorias de carro"
    click_on "A"
    click_on "Editar"
    fill_in "Nome", with: "B"
    fill_in "Diária", with: 100.00
    fill_in "Seguro", with: 55.00
    fill_in "Seguro de terceiros", with: 25.00
    click_on "Atualizar categoria"

    expect(page).to have_content("Dados atualizados com sucesso")
    expect(page).to have_content("Nome: B")
    expect(page).to have_content("Diária: R$ 100,00")
    expect(page).to have_content("Seguro: R$ 55,00")
    expect(page).to have_content("Seguro de terceiros: R$ 25,00")
  end
end