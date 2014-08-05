require 'rails_helper'

describe Card do	
  before :each do
    @test_card = Card.new(original_text: "dog", translated_text: "собака", review_date: "2014-08-03")
  end
  
  it "Is check_translation method work right? Params in method shoud be eq with cell in database" do
    expect(@test_card.check_translation("собака")).to be true
  end
  
  it "Is update_review_date method work right? Update rewie_data shoud pass" do
    expect(@test_card).to respond_to(:update_review_date)
  end
  
end
