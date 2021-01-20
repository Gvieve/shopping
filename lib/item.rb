class Item
  attr_reader :name,
              :price

  def initialize(data)
    @name = data[:name]
    @price = data[:price]
  end

  def price
    @price.gsub(/[^\d\.]/, '').to_f
  end
end
