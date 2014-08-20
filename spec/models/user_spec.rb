require 'rails_helper'

 describe User do

   before :each do
     @password = BCrypt::Password.create('12345')
     @user = User.new(email: "user@user.com", crypted_password: @password, salt: @password.salt)
   end

   it "does check 'place_current_cat_id_to_user method work" do
     expect(@user.set_current_category(1)).to be true
   end

 end
 