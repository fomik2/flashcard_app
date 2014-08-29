require 'rails_helper'

 describe Card do

   before :each do
     @card = Card.new({ original_text: "dog", 
                        translated_text: "собака", 
                        review_date: "2014-08-03", 
                        num_of_wrong: 0,
                        num_of_right: 0 })
   end

   it "check_translation' method work" do
     expect(@card.check_translation("собака")).to be true
   end

   it "review_date change after correct answer" do
     expect{ 
      @card.check_translation("собака")
    }.to change(@card, :review_date).to(Date.tomorrow)
   end

    it "correct review_date change after 3 correct answer " do
     @card_for_check = Card.new({ original_text: "dog",
                                  translated_text: "собака",
                                  review_date: "2014-08-03",
                                  num_of_wrong: 2, 
                                  num_of_right: 3 })
     expect {
       @card_for_check.check_translation("собака")
     }.to change(@card_for_check, :review_date).to(Date.today + 14)
   end

   it "increments number of correct answers" do
    @card_for_check = Card.new({  original_text: "dog",
                                  translated_text: "собака",
                                  review_date: "2014-08-03",
                                  num_of_wrong: 2, 
                                  num_of_right: 4 })
    expect {
       @card_for_check.check_translation("собака")
     }.to change(@card_for_check, :num_of_right).to(5)
   end

   it "correct review_date value change after five correct answers" do
     @card_for_check = Card.new({ original_text: "dog",
                                  translated_text: "собака", 
                                  review_date: "2014-08-03",
                                  num_of_wrong: 2,
                                  num_of_right: 6 })
     expect { 
       @card_for_check.increase_correct_answer_counter 
     }.to change(@card_for_check, :review_date).to(Date.parse("2014-09-10"))
   end

   it "set to zero num_of_right value after three in sequence incorrect answers" do
     @card_for_check = Card.new({ original_text: "dog",
                                  translated_text: "собака",
                                  review_date: "2014-08-03",
                                  num_of_wrong: 3, 
                                  num_of_right: 6 })
     expect {
       @card_for_check.increase_incorrect_answer_counter 
     }.to change( @card_for_check, :num_of_right).to(0)
   end

   it "review_date value change after three in sequence incorrect answers" do
     @card_for_check = Card.new({ original_text: "dog",
                                 translated_text: "собака",
                                 review_date: "2014-08-03",
                                 num_of_wrong: 3,
                                 num_of_right: 4 })
     expect {
       @card_for_check.increase_incorrect_answer_counter 
     }.to change(@card_for_check, :review_date).to(Date.today)
   end

 end
 