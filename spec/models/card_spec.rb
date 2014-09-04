require 'rails_helper'

 describe Card do

   before :each do
     @card = Card.new({ original_text: "dog", 
                        translated_text: "собака", 
                        review_date: "2014-08-03", 
                        interval: 0,
                        efactor: 2.5,
                        number_of_right: 0,
                        number_of_review: 0 })
   end

   it "check_translation' method work" do
     expect(@card.check_translation("собака", 10)).to eq :success
   end

   it "check misprint-checker" do
     expect(@card.check_translation("собакв", 10)).to eq :misprint
   end

    it "correct review_date change after 3 correct answer " do
     @card_for_check = Card.new({ original_text: "dog",
                                  translated_text: "собака",
                                  review_date: "2014-09-03",
                                  interval: 6,
                                  efactor: 2.5,
                                  number_of_right: 3,
                                  number_of_review: 0 })
     expect {
       @card_for_check.check_translation("собака", 10)
     }.to change(@card_for_check, :review_date).to(Date.parse("2014-10-04"))
   end

   it "reset interval after incorrect answers" do
    @card_for_check = Card.new({  original_text: "dog",
                                  translated_text: "собака",
                                  review_date: "2014-08-03",
                                  interval: 3,
                                  efactor: 2.8,
                                  number_of_right: 12,
                                  number_of_review: 3})
    expect {
       @card_for_check.check_translation("кошка", 10)
     }.to change(@card_for_check, :interval).to(0)
   end

   it "reset review_date after incorrect answers" do
    @card_for_check = Card.new({  original_text: "dog",
                                  translated_text: "собака",
                                  review_date: "2014-08-03",
                                  interval: 3,
                                  efactor: 2.8,
                                  number_of_right: 12,
                                  number_of_review: 3})
    expect {
       @card_for_check.check_translation("кошка", 10)
     }.to change(@card_for_check, :review_date).to(Date.today)
   end


 end
 