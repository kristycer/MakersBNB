feature 'MakersBNB has a homepage' do
  scenario 'user visit the homepage and can sign up' do
    visit '/'
    fill_in "name", with: "Owner_1"
    fill_in 'email', with: 'example@me.com' 
    fill_in 'Password', with: '123456'
    fill_in 'Password_confirmation', with: '123456'
    click_button 'Sign up'
    expect(page).to have_content 'Book a space'
  end 

  scenario 'displays a flash message when entered not matching details' do
    visit '/'
    fill_in "name", with: "Owner_1"
    fill_in 'email', with: 'example@me.com' 
    fill_in 'Password', with: '123456'
    fill_in 'Password_confirmation', with: '654321'
    click_button 'Sign up'
    expect(page).to have_content 'Your passwords do not match'
  end 
end 
