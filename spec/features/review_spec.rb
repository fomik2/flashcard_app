require 'rails_helper'

describe "Index Page" do
 
  before(:each) do
    @user = FactoryGirl.create(:user, email: 'test@mail.ru', password: '123456')
    sign_in('test@mail.ru', '123456')
  end
  
  it "can login user" do
    expect(page).to have_content('Login successful')
  end

  it "check behavior then translation is wrong" do
    add_new_category
    FactoryGirl.create(:card, user_id: @user.id)
    visit root_path
    click_on 'Test'
    fill_in 'translated_text', with: 'some text'
    click_on 'Проверить'
    expect(page).to have_content('Неверно!')
  end

  it "check behavior then translation is true" do
    add_new_category
    FactoryGirl.create(:card, user_id: @user.id)
    visit root_path
    click_on 'Test'
    fill_in 'translated_text', with: 'Микрософт'
    click_on 'Проверить'
    expect(page).to have_content('Непросмотренных карточек нет')
  end

  it "check welcome page then user is logged_in" do
    visit root_path
    expect(page).to have_content('Именно')
  end

end
