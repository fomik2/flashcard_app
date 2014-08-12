
  def sign_in 
    FactoryGirl.create(:user)
    visit root_path
    click_link 'Войти'
    fill_in 'email', with: 'test@mail.ru'
    fill_in 'password', with: '12345'
    click_on 'Login'
  end
