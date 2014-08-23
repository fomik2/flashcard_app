require 'rails_helper'

 describe User do

   before :each do
     @user = User.create(email: "user@user.com", password: '12345', password_confirmation: '12345')
     @category = Category.create(name: "Test", about: "Test category", user_id: @user.id) 
   end

   it "does check 'set_current_category' method work" do
     expect { @user.set_current_category(@category.id) }.to change(@user, :current_category_id).to(@category.id)
   end

 end
 