
  def sign_in(email, password)
    @user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Войти'
    fill_in 'email', with: email
    fill_in 'password', with: password
    click_on 'Login'
  end


