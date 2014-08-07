require 'rails_helper'

describe "Index Page" do
  
  before(:each) do
    @card = FactoryGirl.create(:card)
    DatabaseCleaner.start
  end

  it "shows error messages if translation is wrong" do
    visit root_path
    fill_in 'translated_text', with: 'wqww'
    click_on 'Проверить'
    expect(page).to have_content('Неверно!')
  end

  after (:each) do
  DatabaseCleaner.clean
  end

end
