
feature 'MakersBNB has a homepage' do
    scenario 'user visit the homepage and can sign up' do
        visit '/'
        fill_in "name", with: "Owner_1"
        fill_in 'email', with: 'example@me.com'
        fill_in 'Password', with: '123456'
        fill_in 'Password confirmation', with: '123456'
        click_button 'Sign up'
        expect(page).to have_content 'Book a space'
        
    end 

    
end 