feature 'user can list a property' do

scenario 'user can fill in the details of the property' do
sign_up
visit '/spaces/new'
fill_in "property-name", with: 'London Penthouse'
fill_in "property-description", with: 'Stunning views'
fill_in "property-location", with: 'London'
fill_in "property-price", with: '1000'
fill_in 'available-from', with: '2020-09-08'
fill_in 'available-to', with: '2020-09-30'
click_button 'Create listing'
expect(page).to have_content 'Book a space' #just checking it goes to right page


    end 
end 