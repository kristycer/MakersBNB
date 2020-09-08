require './models/space'

describe 'spaces' do
  it 'can create a space' do
    owner = User.create(name: 'Example', email: 'example@me.com', password: 'password123')

    space = Space.new(name: 'Test Property', description: 'Something here', location: 'London', price: 5.00, available_from: '2020-10-01', available_to: '2020-11-01', owner: owner.id )

    expect(space.name).to eq 'Test Property'
    expect(space.location).to eq 'London'
    expect(space.available_from).to eq '2020-10-01'
    expect(space.available_to).to eq '2020-11-01'
  end

  it 'can show a space' do
    
  end
end
