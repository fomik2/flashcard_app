require 'rails_helper'

RSpec.describe User, :type => :model do
  
  it "can add new card" do
    FactoryGirl.create(:user)
  end

end
