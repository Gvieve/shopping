require 'date'

class Market
  attr_reader :name,
              :date,
              :vendors

  def initialize(name)
    @name = name
    @date = Date.today.strftime("%d/%m/%Y")
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

  def overstocked_items
    total_inventory.map do |item, info|
      item if info[:quantity] > 50 && info[:vendors].length > 1
    end.compact
  end

  def sorted_item_list
    @vendors.flat_map do |vendor|
      vendor.inventory.keys.map do |item|
        item.name
      end
    end.uniq.sort
  end

  def sell(item, quantity)
    if total_inventory[item].nil? || total_inventory[item][:quantity] < quantity
      return false
    end

    require "pry"; binding.pry

  end
end
