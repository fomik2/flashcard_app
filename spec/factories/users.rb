FactoryGirl.define do
  factory :user do
    email :email
    password :password
    password_confirmation { password }
  end
end
