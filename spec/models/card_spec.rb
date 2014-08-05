require 'rails_helper'

describe Card, :type => :model do	
  before :each do
    @test_card = Card.new(original_text: "dog", translated_text: "собака", review_date: "2014-08-03")
  end
  
  it "Check translation test" do
    expect(@test_card.check_translation("собака")).to eq(true)
  end
  
  it "Update review date test" do
    expect(@test_card).to respond_to(:update_review_date)
  end
end