def add_new_category
  visit root_path
  click_link 'Добавить категорию'
  fill_in 'category[name]', with: 'test'
  fill_in 'category[about]', with: 'test'
  click_on 'Create Category'
end
