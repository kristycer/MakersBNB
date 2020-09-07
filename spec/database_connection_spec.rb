require './models/database_connection'

describe DatabaseConnection do
  let(:connection) { DatabaseConnection.setup('makersbnb_test') }
    
  describe '#.setup' do
    it 'connects to the correct database' do
      connection = DatabaseConnection.setup('makersbnb_test')
      expect(connection.db).to eq 'makersbnb_test'
    end
      
    it 'has a persistent connection' do
      connection = DatabaseConnection.setup('makersbnb_test')

      expect(DatabaseConnection.connection).to eq connection
    end
  end
    
  describe '.query' do
    it 'executes a SQL query via PG' do
      connection = DatabaseConnection.setup('makersbnb_test')
      
      expect(connection).to receive(:exec).with("SELECT * FROM users;")

      DatabaseConnection.query("SELECT * FROM users;")
    end
  end
end
