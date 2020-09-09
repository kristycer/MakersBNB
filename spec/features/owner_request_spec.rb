feature "Owner gets request and see the page" do 
  scenario "Owner request page is displayed" do 
    sign_up
    click_link "Requests"
    expect(page).to have_content "Requests"
  end
end