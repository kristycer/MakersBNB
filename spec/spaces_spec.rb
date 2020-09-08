require './models/space'

describe 'spaces' do
  it 'can create a space' do
    owner = User.create(name: 'Example', email: 'example@me.com', password: 'password123')

    space = Space.create(name: 'Test Property', description: 'Something here', location: 'London', price: 5.00, available_from: '2020-10-01', available_to: '2020-11-01', owner: owner.id )

    expect(space.name).to eq 'Test Property'
    expect(space.location).to eq 'London'
    expect(space.available_from).to eq '2020-10-01'
    expect(space.available_to).to eq '2020-11-01'
  end

  it 'can show all spaces' do
    owner = User.create(name: 'Example', email: 'example@me.com', password: 'password123')

    space = Space.create(name: 'Test Property', description: 'Something here', location: 'London', price: 5.00, available_from: '2020-10-01', available_to: '2020-11-01', owner: owner.id )

    all_spaces = Space.all
    expect(all_spaces.first.name).to eq 'Test Property'
    expect(all_spaces.first.location).to eq 'London'
    expect(all_spaces.first.available_from).to eq '2020-10-01'
    expect(all_spaces.first.available_to).to eq '2020-11-01'
    
  end

  it"Search for available space" do 

    owner = User.create(name: 'Example', email: 'example@me.com', password: 'password123')

    space = Space.create(name: 'Test Property', description: 'Something here', location: 'London', price: 5.00, available_from: '2020-10-01', available_to: '2020-11-01', owner: owner.id )

    Space.create(name: 'Test Property 2', description: 'Something here', location: 'London', price: 5.00, available_from: '2020-08-01', available_to: '2020-09-01', owner: owner.id )

    expect(Space.search("2020-10-01",'2020-11-01').length).to eq 1
    expect(Space.search("2020-10-01",'2020-11-01').first.name).to eq "Test Property"
    expect(Space.search("2020-10-01",'2020-11-01').first.name).not_to eq "Test Property 2"
    

  end

  it "Search for all properties with statrt date only" do 
    owner = User.create(name: 'Example', email: 'example@me.com', password: 'password123')

    space = Space.create(name: 'Test Property', description: 'Something here', location: 'London', price: 5.00, available_from: '2020-10-01', available_to: '2020-11-01', owner: owner.id )

    Space.create(name: 'Test Property 2', description: 'Something here', location: 'London', price: 5.00, available_from: '2020-08-01', available_to: '2020-09-01', owner: owner.id )

    expect(Space.search("2020-10-01").length).to eq 1
    expect(Space.search("2020-10-01").first.name).to eq "Test Property"
    expect(Space.search("2020-10-01").first.name).not_to eq "Test Property 2"

  end


end
