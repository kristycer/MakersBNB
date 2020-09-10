require 'pg'

def setup_test_database
  connection = PG.connect(dbname: 'makersbnb_test')

  connection.exec("TRUNCATE users, spaces, requests, confirmations RESTART IDENTITY;")
end
