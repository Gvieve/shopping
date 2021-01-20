class Vendor
  attr_reader :name,
              :inventory

  def initialize(name)
    @name = name
    @inventory = {}
  end

  def stock(item, quantity)
    if @inventory[item].nil?
      @inventory[item] = quantity
    else
      @inventory[item] += quantity
    end
  end

  def check_stock(item)
    @inventory[item].nil? ? 0 : @inventory[item]
  end

  def sell_item?(name)
    @inventory.keys.any? do |item|
      item.name == name
    end
  end
end
