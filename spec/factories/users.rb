FactoryGirl.define do
  factory :user do
    email "test@mail.ru"
    password "12345"
    password_confirmation "12345"
  end
end
