require 'rails_helper'

describe "New Card Page" do
 
  before(:each) do
    @user = FactoryGirl.create(:user, email: 'test@mail.ru', password: '123456')
    FactoryGirl.create(:category, user_id: @user.id)
    sign_in('test@mail.ru', '123456')
  end

  it "check add card" do
    visit root_path
    click_on 'Все категории'
    
    click_on 'Добавить карточку'
    attach_file('card[picture]', File.join(Rails.root, '/spec/support/images/test.png' ))
    fill_in 'card[original_text]', with: 'test'
    fill_in 'card[translated_text]', with: 'тест'
    select '2013', from: 'card[review_date(1i)]'
    select 'February', from: 'card[review_date(2i)]'
    select '12', from: 'card[review_date(3i)]'
    select 'Test', from: 'card[category_id]'
    click_on 'Create Card'
    expect(page).to have_content('тест')
  end

end
