include ActionDispatch::TestProcess #для загрузки файлов. 
FactoryGirl.define do
  factory :card do
    picture { fixture_file_upload(Rails.root.join('spec', 'support', 'images', 'test.png'), 'image/png') }
    original_text "Microsoft"
    translated_text "Микрософт"
    review_date "2013-06-06"
    category_id "1"
    interval 0
    number_of_review 0
    efactor 2.5
  end

  factory :category do
    name "Test"
    about "TestCategory"
  end

end
