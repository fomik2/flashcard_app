require 'rails_helper'

describe "Index Page" do
 
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in('test@mail.ru', '12345')
  end
  
  it "can login user" do
    expect(page).to have_content('Login successful')
  end

  it "check behavior then translation is wrong" do
    FactoryGirl.create(:card, user_id: @user.id)
    visit root_path
    fill_in 'translated_text', with: 'some text'
    click_on 'Проверить'
    expect(page).to have_content('Неверно!')
  end

  it "check behavior then translation is true" do
    FactoryGirl.create(:card, user_id: @user.id)
    visit root_path
    fill_in 'translated_text', with: 'Микрософт'
    click_on 'Проверить'
    expect(page).to have_content('Непросмотренных карточек нет')
  end

  it "check welcome page then user is logged_in" do
    visit root_path
    expect(page).to have_content('Именно')
  end
  
  it "check add card" do
    FactoryGirl.create(:card, user_id: @user.id)
    visit root_path
    click_on 'Добавить карточку'
    fill_in 'card[original_text]', with: 'test'
    fill_in 'card[translated_text]', with: 'тест'
    select '2013', from: 'card[review_date(1i)]'
    select 'February', from: 'card[review_date(2i)]'
    select '12', from: 'card[review_date(3i)]'
    click_on 'Create Card'
    expect(page).to have_content('тест')
  end
  
  it "check update method" do
    visit root_path
    click_link 'Редактировать профиль'
    fill_in 'user[password_confirmation]', with: '12345'
    fill_in 'user[password]', with: '12345'
    click_on 'Update User'
    expect(page).to have_content('Флэшкарточкер')
  end

end
