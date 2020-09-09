require './models/booking'

describe 'booking' do
  it 'can create a new booking' do
  owner = User.create(name: 'Owner Example', email: 'exampleowner@me.com', password: 'password123')

  user = User.create(name: 'User Example', email: 'exampleuser@me.com', password: 'password123')

  space = Space.create(name: 'Test Property', description: 'Something here', location: 'London', price: 5.00, available_from: '2020-10-01', available_to: '2020-11-01', owner: owner.id)

  booking = Booking.create(property_name: 'Test Property', booking_date: '2020-10-03' , total_price: 5.00, name: 'User Example', email: 'exampleowner@me.com')

  expect(booking.property_name).to eq 'Test Property' 
  expect(booking.booking_date).to eq '2020-10-03'
  expect(booking.name).to eq 'User Example'
  end

end 