require 'rails_helper'

 describe Category do

   before :each do
     @category = Category.new(name: "Test", about: "Test", activate: false)
     @param_for_test = Category.all
   end

  it "check default status of new category" do
     expect(@category.activate).to eq false
   end

   it "does check 'set_categories_to_true' method work" do
     @category.set_categories_to_true(@param_for_test)
     expect(@category.activate).to eq true
   end

 end
