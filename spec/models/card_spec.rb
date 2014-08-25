require 'rails_helper'

 describe Card do

   before :each do
     @card = Card.new(original_text: "dog", translated_text: "собака", review_date: "2014-08-03", 
       num_of_wrong: 0, num_of_right: 0)
   end

   it "does check 'checkTranslation' method work" do
     expect(@card.checkTranslation("собака")).to be true
   end

   it "does check 'thenTranslationTrue' method work" do
     expect{ @card.thenTranslationTrue }.to change(@card, :review_date).to(Date.today)
   end

    it "does check 'thenTranslationTrue(review_date chenger check)' method work" do
     @card_for_check = Card.new(original_text: "dog", translated_text: "собака", review_date: "2014-08-03", 
       num_of_wrong: 2, num_of_right: 4)
     expect{ @card_for_check.thenTranslationTrue }.to change(@card_for_check, :review_date).to(Date.today + 14)
   end

   it "does check 'thenTranslationFalse (change num_of_right)' method work" do
     @card_wrong_translation = Card.new(original_text: "dog", translated_text: "собака", review_date: "2014-08-03", 
       num_of_wrong: 3, num_of_right: 4)
     expect{ @card_wrong_translation.thenTranslationFalse }.to change(@card_wrong_translation, :num_of_right).to(1)
   end

   it "does check 'thenTranslationFalse (change_review_date)' method work" do
     @card_wrong_translation = Card.new(original_text: "dog", translated_text: "собака", review_date: "2014-08-03", 
       num_of_wrong: 3, num_of_right: 4)
     expect{ @card_wrong_translation.thenTranslationFalse }.to change(@card_wrong_translation, 
       :review_date).to(Date.today.next)
   end

 end
 