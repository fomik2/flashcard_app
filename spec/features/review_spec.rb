require 'rails_helper'

describe "Index Page" do
 
  before(:each) do
    sign_in
  end

  it "check behavior then translation is wrong" do
    FactoryGirl.create(:card, user_id: '1')
    visit root_path
    fill_in 'translated_text', with: 'some text'
    click_on 'Проверить'
    expect(page).to have_content('Неверно!')
  end

  it "check behavior then translation is true" do
    FactoryGirl.create(:card, user_id: '1')
    visit root_path
    fill_in 'translated_text', with: 'Микрософт'
    click_on 'Проверить'
    expect(page).to have_content('Непросмотренных карточек нет')
  end

  it "check welcome page then user is logged_in" do
    visit root_path
    expect(page).to have_content('Именно')
  end

end
