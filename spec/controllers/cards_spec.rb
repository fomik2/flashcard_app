require 'rails_helper'

describe CardsController, type: "controller:" do 
  it "Render New card template" do
    get :new
    expect(response).to be_success
  end
  
 end
