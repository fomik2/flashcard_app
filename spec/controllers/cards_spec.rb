require 'rails_helper'

describe CardsController, :type => :controller do 
  it "Render New card template" do
    get :new
    expect(response).to be_success
    expect(response).to have_http_status(200)
  end
 end