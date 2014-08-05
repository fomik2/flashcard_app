require 'rails_helper'

describe CardsController do 
  it "Render New card template" do
    get :new
    expect(response).to be_success
  end

end
