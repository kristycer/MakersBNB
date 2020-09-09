feature 'Booking' do
    scenario 'user can make a booking' do
            visit '/'
            sign_up
            log_in
            visit '/spaces'
            list_a_space
        first('.space').click_button 'Book'
        expect(page).to have_content('Booking confirmed')
        expect(page).to have_content('Pick a night')
    end 
end 