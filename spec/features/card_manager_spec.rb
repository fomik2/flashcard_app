require 'rails_helper'
require 'users_helper'

describe "New card Page" do

  before(:each) do
    sign_in
  end

  it "can user login" do
    expect(page).to have_content('Login successful')
  end

end
