require 'rails_helper'

 describe Card do

   before :each do
     @card = Card.new({original_text: "dog", 
      translated_text: "собака", 
      review_date: "2014-08-03", 
       num_of_wrong: 0,
       num_of_right: 0})
   end

   it "does check 'check_translation' method work" do
     expect(@card.check_translation("собака")).to be true
   end

   it "does check 'check_translation' method work" do
     expect{ @card.check_translation("собака") }.to change(
       @card, :review_date).to(Date.today.next)
   end

    it "does check 'check_translation (review_date changer check)' method work" do
     @card_for_check = Card.new({ original_text: "dog",
                                  translated_text: "собака",
                                  review_date: "2014-08-03",
                                  num_of_wrong: 2, 
                                  num_of_right: 3 })
     expect {
       @card_for_check.check_translation("собака")
     }.to change(@card_for_check, :review_date).to(Date.today + 14)
   end

   it "does check 'check_translation (num_of_right changer)' method work" do
     @card_for_check = Card.new({ original_text: "dog",
                                 translated_text: "собака",
                                 review_date: "2014-08-03",
                                 num_of_wrong: 2,
                                 num_of_right: 4})
     expect {
       @card_for_check.check_translation("собака")
     }.to change(@card_for_check, :num_of_right).to(5)
   end

   it "does check 'increase_correct_answer_counter' method work" do
     @card_for_check = Card.new({ original_text: "dog",
                                  translated_text: "собака", 
                                  review_date: "2014-08-03",
                                  num_of_wrong: 2,
                                  num_of_right: 6})
     expect { 
       @card_for_check.increase_correct_answer_counter 
     }.to change(@card_for_check, :review_date).to(Date.parse("2014-09-10"))
   end

   it "does check 'increase_incorrect_answer_counter (change num_of_right)' method work" do
     @card_for_check = Card.new({ original_text: "dog",
                                  translated_text: "собака",
                                  review_date: "2014-08-03",
                                  num_of_wrong: 3, 
                                  num_of_right: 6})
     expect {
       @card_for_check.increase_incorrect_answer_counter 
     }.to change( @card_for_check, :num_of_right).to(1)
   end

   it "does check 'increase_incorrect_answer_counter (change_review_date)' method work" do
     @card_for_check = Card.new({ original_text: "dog",
                                 translated_text: "собака",
                                 review_date: "2014-08-03",
                                 num_of_wrong: 3,
                                 num_of_right: 4})
     expect {
       @card_for_check.increase_incorrect_answer_counter 
     }.to change(@card_for_check, :review_date).to(Date.today.next_day)
   end

 end
 