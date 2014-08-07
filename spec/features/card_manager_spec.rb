require 'rails_helper'

describe "New card Page" do
  
  before(:each) do
    @card = FactoryGirl.create(:card)
  end

  it "can add new card" do
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
  
end
