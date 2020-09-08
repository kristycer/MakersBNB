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
