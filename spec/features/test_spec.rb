require 'rails_helper'

describe "Index Page" do
  
  before(:each) do
    @card = FactoryGirl.create(:card)
  end

  it "should have content 'Именно'" do
  	visit '/'
  	expect(page).to have_content('Именно')
  end

  it "does test fail translate from user" do
  	visit root_path
  	fill_in 'translated_text', with: 'wqww'
  	click_on 'Проверить'
  	expect(page).to have_content('Неверно!')
  end

  it "does New page create a new object and add it to database" do
  	visit new_card_path
  	expect(page).to have_content('Add new card')
  	fill_in 'card[original_text]', with: 'test'
  	fill_in 'card[translated_text]', with: 'тест'
  	select '2013', from: 'card_review_date_1i'
  	select 'January', from: 'card_review_date_2i'
  	select '12', from: 'card_review_date_3i'
  	click_on 'Create Card'
  	expect(page).to have_content('test')
  end

  after(:each) do
  	
  end

end