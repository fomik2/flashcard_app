include ActionDispatch::TestProcess #для загрузки файлов. 
FactoryGirl.define do
  factory :card do
    picture { fixture_file_upload(Rails.root.join('spec', 'support', 'images', 'test.png'), 'image/png') }
    original_text "Microsoft"
    translated_text "Микрософт"
    review_date "2013-06-06"
    category_id "1"
    num_of_right 0
    num_of_wrong 0
  end

  factory :category do
    name "Test"
    about "TestCategory"
  end

end
