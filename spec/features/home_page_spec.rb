
feature 'MakersBNB has a homepage' do
    scenario 'user visit the homepage and can sign up' do
        visit '/'
        expect(page).to have_content 'MakersBNB'
    end 
end 