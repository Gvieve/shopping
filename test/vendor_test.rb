require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/vendor'

class VendorTest < Minitest::Test
  def test_it_exists_and_has_attributes
    vendor = Vendor.new("Rocky Mountain Fresh")

    assert_instance_of Vendor, vendor
    assert_equal 'Rocky Mountain Fresh', vendor.name
    assert_equal ({}), vendor.inventory
  end

  def test_it_can_stock_items
    vendor = Vendor.new("Rocky Mountain Fresh")
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})

    assert_equal 0, vendor.check_stock(item1)

    vendor.stock(item1, 30)
    expected1 = {item1 => 30}

    assert_equal expected1, vendor.inventory
    assert_equal 30, vendor.check_stock(item1)

    vendor.stock(item1, 25)

    assert_equal 55, vendor.check_stock(item1)

    vendor.stock(item2, 12)
    expected2 = {item1 => 55, item2 => 12}

    assert_equal expected2, vendor.inventory
  end

  def test_sell_item?
    vendor = Vendor.new("Rocky Mountain Fresh")
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    vendor.stock(item1, 30)
    vendor.stock(item1, 25)
    vendor.stock(item2, 12)

    assert_equal true, vendor.sell_item?('Peach')
  end

  def test_potential_revenue
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: "$0.50"})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.00"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    vendor1.stock(item1, 100)
    vendor1.stock(item2, 10)
    vendor2 = Vendor.new("Ba-Nom-a-Nom")
    vendor2.stock(item4, 4)
    vendor2.stock(item3, 20)
    vendor3 = Vendor.new("Palisade Peach Shack")
    vendor3.stock(item1, 100)

    assert_equal 80.00, vendor1.potential_revenue
    assert_equal 117.00, vendor2.potential_revenue
    assert_equal 75.00, vendor3.potential_revenue
  end
end
