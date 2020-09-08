feature 'logging in' do
  it 'allows users to log in' do
    sign_up
    log_in
  
    expect(page).to have_content('John')
  end
end
