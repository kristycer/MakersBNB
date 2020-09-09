feature 'Booking' do
    scenario 'user can make a booking' do
            visit '/'
            sign_up
            log_in
            visit '/spaces'
            list_a_space
            click_button 'Book'
        expect(page).to have_content('Make a Booking')
        expect(page).to have_content('Date of Stay')
    end 
end 