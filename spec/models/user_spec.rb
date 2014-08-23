require 'rails_helper'

 describe User do

   before :each do
     @user = User.new(email: "user@user.com", password: '12345', password_confirmation: '12345')
     @current_category = 1
   end

   it "does check 'set_current_category' method work" do
     expect { @user.set_current_category(@current_category) }.to change(@user, :current_category_id).to(1)
   end

 end
 