require './models/database_connection'

class Confirmation

  attr_reader :property_id, :booking_date

  def initialize(property_id:, booking_date:)
    @property_id = property_id
    @booking_date = booking_date
  end

  def self.confirm(property_id:, booking_date:)
    confirmation = DatabaseConnection.query(
      "INSERT INTO confirmations (property_id, booking_date) 
      VALUES('#{property_id}','#{booking_date}') 
      RETURNING property_id, booking_date;")

      Confirmation.new(property_id: confirmation[0]['property_id'], booking_date: confirmation[0]['booking_date'])
  end

  def self.find(property_id:)
    results = DatabaseConnection.query("SELECT * FROM confirmations WHERE property_id = '#{property_id}';")

        results.map do |booking| 
          Confirmation.new(
            property_id: booking['property_id'], booking_date: booking['booking_date'])
          end
  end
end