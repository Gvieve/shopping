class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item_name)
    @vendors.find_all do |vendor|
      vendor.sell_item?(item_name)
    end
  end

  def total_inventory
    totals = {}
    @vendors.each do |vendor|
      vendor.inventory.each do |item, qty|
        if totals[item].nil?
          totals[item] = {quantity: 0, vendors: []}
        end

        totals[item][:quantity] += qty
        totals[item][:vendors].push(vendor)
      end
    end

    totals
  end
end
