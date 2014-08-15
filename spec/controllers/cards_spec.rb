require 'rails_helper'

describe CardsController do

  it "test redirect not_logged user to login path" do
    get :new, user_id: '1'
    expect(response).to redirect_to login_path
  end
  
end
