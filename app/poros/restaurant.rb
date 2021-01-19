class Restaurant
  attr_reader :name, :address
  def initialize(data)
    @name = data[:name]
    @address = address_one_line(data[:location][:display_address])
  end

  def address_one_line(data)
    data.join(", ")
  end
end
