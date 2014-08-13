require 'rails_helper'

describe "New card Page" do

  before(:each) do
    sign_in
  end

  it "can login user" do
    expect(page).to have_content('Login successful')
  end

end
