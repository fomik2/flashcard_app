require 'rails_helper'

describe "Index Page" do

  it "shows error messages if translation is wrong" do
    @card = FactoryGirl.create(:card)
    visit root_path
    fill_in 'translated_text', with: 'some text'
    click_on 'Проверить'
    expect(page).to have_content('Неверно!')
  end

  it "check page then object is not created" do
    visit root_path
    save_and_open_page
    expect(page).to have_content('Непросмотренных')
  end

end
