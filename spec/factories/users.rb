FactoryGirl.define do
  factory :user do
    email 'test@mail.ru'
    password '12345'
    password_confirmation { password }
  end
end
