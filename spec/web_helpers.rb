def sign_up(name: 'John', email: 'john@email.com', password: '12345', password_confirmation: '123456')
  visit '/'
  fill_in 'name', with: name
  fill_in 'email', with: email
  fill_in 'Password', with: password
  fill_in 'Password confirmation', with: password_confirmation
  click_button 'Sign up'
end 

def log_in(email: 'john@email.com', password: '12345')
  visit '/log_in'
  fill_in 'email', with: email
  fill_in 'Password', with: password
  click_button 'Log in'
end 

def list_a_space(name: 'Test Property', description: 'Something here', location: 'London', price: 5.00, available_from: '2020-10-01', available_to: '2020-11-01', owner: '1')
  visit '/spaces/new'
    fill_in "property-name", with: 'London Penthouse'
    fill_in "property-description", with: 'Stunning views'
    fill_in "property-location", with: 'London'
    fill_in "property-price", with: '1000'
    fill_in 'available-from', with: '2020-09-08'
    fill_in 'available-to', with: '2020-09-30'
    click_button 'Create listing'

end 

