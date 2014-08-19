def add_new_category
  visit root_path
  click_link 'Добавить категорию'
  fill_in 'category[name]', with: 'Test'
  fill_in 'category[about]', with: 'Test Category'
  click_on 'Create Category'
end

def make_test_category_active
visit root_path
click_link 'Все категории'
click_link 'Активировать'
end
