require 'rails_helper'

describe "Edit User Page" do
 
  before(:each) do
    @user = FactoryGirl.create(:user, email: 'test@mail.ru', password: '123456')
    sign_in('test@mail.ru', '123456')
  end
  
  it "can login user" do
    expect(page).to have_content('Login successful')
  end
  
  it "check update method" do
    visit root_path
    click_link 'Редактировать профиль'
    fill_in 'user[password_confirmation]', with: '12345'
    fill_in 'user[password]', with: '12345'
    click_on 'Update User'
    expect(page).to have_content('Флэшкарточкер')
  end

  it "check error when password_confirmation != password" do
    visit root_path
    click_link 'Редактировать профиль'
    fill_in 'user[password_confirmation]', with: '123456'
    fill_in 'user[password]', with: '12345'
    click_on 'Update User'
    expect(page).to have_content("Password confirmation doesn't match Password")
  end

end
