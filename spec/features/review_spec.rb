require 'rails_helper'

describe "Index Page" do

  it "check behavior then translation is wrong" do
    FactoryGirl.create(:card)
    visit root_path
    fill_in 'translated_text', with: 'some text'
    click_on 'Проверить'
    expect(page).to have_content('Неверно!')
  end

  it "check behavior then translation is true" do
    FactoryGirl.create(:card)
    visit root_path
    fill_in 'translated_text', with: 'Микрософт'
    click_on 'Проверить'
    expect(page).to have_content('Непросмотренных карточек нет')
  end

  it "check page then object is not created" do
    visit root_path
    expect(page).to have_content('Непросмотренных')
  end

end
