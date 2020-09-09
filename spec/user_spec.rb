require './models/user'

describe User do
  describe '.create' do
    it 'creates a new user' do
      user = User.create(name: 'Example', email: 'example@me.com', password: 'password123')
       
      expect(user.name).to eq 'Example'
      expect(user.email).to eq 'example@me.com'
    end
  end

  describe '.find' do
    it 'finds the user by an id' do
      User.create(name: 'Example', email: 'example@me.com', password: 'password123')
      user = User.find(id: 1)

      expect(user.name).to eq 'Example'
      expect(user.id).to eq '1'
    end
  end

  describe '.authenticate' do
    it 'returns a user given correct sign in details' do
      user = User.create(name: 'Example', email: 'example@me.com', password: 'password123')
      authenticated_user = User.authenticate(email: 'example@me.com', password: 'password123')

      expect(authenticated_user.id).to eq user.id
    end

    it 'does not returns a user given correct sign in details' do
      User.create(name: 'Example', email: 'example@me.com', password: 'password123')

      expect(User.authenticate(email: 'wrong@me.com', password: 'password123')).to be_nil
    end
  end

  describe '#requests' do
    it "owner can see requests" do
      user = User.create(name: 'Example', email: 'example@me.com', password: 'password123')
      user.book_request('house')
      expect(user.requests.length).to eq 2
    end
  end
end
