require './models/database_connection'

class Space

  attr_reader :id, :name, :description, :location, :price, :available_from, :available_to, :owner

  def initialize(id:, name:, description:, location:, price:, available_from:, available_to:, owner:)
    @id = id
    @name = name
    @description = description
    @location = location
    @price = price
    @available_from = available_from
    @available_to = available_to
    @owner = owner
  end

  def self.create(name:, description:, location:, price:, available_from:, available_to:, owner:)
    space = DatabaseConnection.query("INSERT INTO spaces(name, description, location, price, available_from, available_to, owner) VALUES('#{name}','#{description}','#{location}','#{price}','#{available_from}','#{available_to}','#{owner}') RETURNING id, name, description, location, price, available_from, available_to, owner;")

    Space.new(id: space[0]['id'], name: space[0]['name'], description: space[0]['description'], location: space[0]['location'], price: space[0]['price'], available_from: space[0]['available_from'], available_to: space[0]['available_to'], owner: space[0]['owner'])
  end


  def self.all 
    spaces = DatabaseConnection.query("SELECT * FROM spaces")
    
    spaces.map do |space| 
      Space.new(id: space['id'], name: space['name'], description: space['description'], location: space['location'], price: space['price'], available_from: space['available_from'], available_to: space['available_to'], owner: space['owner'])
    end
    
  end

  def self.search(available_from, available_to = nil)

    if available_to != nil
      spaces = DatabaseConnection.query("SELECT * FROM spaces WHERE available_from >= ('#{available_from}') AND available_to <= ('#{available_to}')")
    else 
      spaces = DatabaseConnection.query("SELECT * FROM spaces WHERE available_from = ('#{available_from}')")
    end

    spaces.map do |space| 
      Space.new(id: space['id'], name: space['name'], description: space['description'], location: space['location'], price: space['price'], available_from: space['available_from'], available_to: space['available_to'], owner: space['owner'])
    end
  end

end