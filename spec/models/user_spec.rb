require 'rails_helper'

 describe User do

   before :each do
     @user = User.new(email: "user@user.com", password: '12345', password_confirmation: '12345')
   end

   it "does check 'set_current_category' method work" do
     expect(@user.set_current_category(1)).to be true
   end

 end
 