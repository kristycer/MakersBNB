feature 'user can list a property' do

  scenario 'user can fill in the details of the property' do
    sign_up
    create_listing
    expect(page).to have_content 'London Penthouse' # just checking it goes to right page
  end 
end 
