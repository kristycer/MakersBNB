require './models/database_connection'

class Space

  attr_reader :name, :description, :location, :price, :available_from, :available_to, :ower

  def initialize(name:, description:, location:, price:, available_from:, available_to:, owner:)
    @name = name
    @description = description
    @location = location
    @price = price
    @available_from = available_from
    @available_to = available_to
    @owner = owner
  end

  def self.create(name:, description:, location:, price:, available_from:, available_to:, owner:)
    space = DatabaseConnection.query("INPUT INTO spaces(name, description, location, price, available_from, available_to, ower) VALUES('#{}','#{}','#{}','#{}','#{}','#{}','#{}') RETURNING id, name, description, location, price, available_from, available_to, owner;")

    Space.new(id: space[0]['id'], name: space[0]['name'], description: space[0]['description'], location: space[0]['location'], price: space[0]['price'], available_from: space[0]['available_from'], available_to: space[0]['available_to'], owner: space[0]['owner'])
  end
end