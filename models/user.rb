require './models/database_connection'
require 'bcrypt'

class User 

  attr_reader :id, :name, :email, :requests

  def initialize(id:, name:, email:)
    @id = id
    @name = name
    @email = email
    @requests = [ 
      {
        "house" => "House Swamp",
        "name" => "John",
        "email" => "john@email.com"
      }
    ]
  end

  def self.create(name:, email:, password:)
    encrypted_password = BCrypt::Password.create(password)
    user = DatabaseConnection.query(
      "Insert INTO users (name, email, password) 
      VALUES ('#{name}', '#{email}', '#{encrypted_password}') RETURNING id, name, email;")
    User.new(id: user[0]['id'], name: user[0]['name'], email: user[0]['email'])
  end

  def self.find(id:)
    search = DatabaseConnection.query("SELECT * FROM users WHERE id = '#{id}'")
    User.new(id: search[0]['id'], name: search[0]['name'], email: search[0]['email'])
  end

  def self.authenticate(email:, password:)
    search = DatabaseConnection.query("SELECT * FROM users WHERE email = '#{email}'")

    return unless search.any?

    return unless BCrypt::Password.new(search[0]['password']) == password

    User.new(id: search[0]['id'], email: search[0]['email'], name: search[0]['name'])
  end  

  def book_request(request)
    @requests << request
  end
end
