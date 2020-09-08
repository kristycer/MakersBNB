feature 'Signing up' do
  it 'allows users to sign up for MakersBNB' do
    sign_up

    expect(page).to have_content "John"
  end
end