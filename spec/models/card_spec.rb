require 'rails_helper'

 describe Card do

   before :each do
     @card = Card.new(original_text: "dog", translated_text: "собака", review_date: "2014-08-03")
   end

   it "does check 'check_translation' method work" do
     expect(@card.check_translation("собака")).to be true
   end

   it "does check 'update_review_data' method work" do
     expect(@card).to respond_to(:update_review_date)
   end

 end
 