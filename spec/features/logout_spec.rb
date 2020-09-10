feature 'logging out' do
    scenario 'a logged in  user can log out' do
    sign_up
    click_link 'Log out'
    expect(page).to have_content 'You have logged out'
    expect(page).to have_current_path '/log_in'
    end 
end 