require 'test_helper'

class ProductTest < ActiveSupport::TestCase
;   fixtures :products
   test "product attributes must not be empty" do
     product = Product.new
     assert product.invalid?
     assert product.errors[:title].any?
     assert product.errors[:description].any?
     assert product.errors[:price].any?
     assert product.errors[:image_url].any?
   end

   test "product price must be positive" do
     product = Product.new(title: "test prd",
                            description: "My desc",
                            image_url: "zzz.jpg")
     product.price = -1

     assert product.invalid?, "price must be greather or equal 0.01"

     product.price = 0

     assert product.invalid?, "price must be greather or equal 0.01"

     product.price = 1
     assert product.valid?
   end

  def new_product(image_url)
    Product.new(title: "My book",
                description: "My desc",
                price: 1,
                image_url: image_url)
  end

  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
            http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be invalid"
    end

    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end

  end

end