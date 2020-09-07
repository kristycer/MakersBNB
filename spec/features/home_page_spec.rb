
feature 'MakersBNB has a homepage' do
    scenario 'user visit the homepage and can sign up' do
        visit '/'
        fill_in 'Email address', with: 'example@me.com'
        fill_in 'Password', with: '123456'
        fill_in 'Password confirmation', with: '123456'
        click_button 'Sign up'
        expect(page).to have_content 'Book a space'
        
    end 

    scenario "User can log in" do 
        visit'/'
        click_link "Log in"
        fill_in 'Email address', with: 'example@me.com'
        fill_in 'Password', with: '123456'
        click_button "Log in"
        expect(page).to have_content 'Book a space'
    end

end 