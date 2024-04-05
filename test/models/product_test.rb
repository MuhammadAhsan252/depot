require "test_helper"

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  test "Product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
  end

  test "Product Price should be positive" do
    product = Product.new(
      title: "My Book",
      description: "My",
      image_url: "zz.jpg"
    )
    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(
      title: "My Book",
      description: "My",
      price: 1,
      image_url: image_url
    )
  end


  test "image url" do
    
    ok = %w{fred.gif jj.jpg wr.png ok.jpeg}
    bad = %w{ asa.doc asdsf.pdf}

    ok.each do |image_url|
      assert new_product(image_url).valid?
    end

    bad.each do |image_url|
      assert new_product(image_url).invalid?
    end
  end

  test 'product is not valid without a unique title' do
    product = Product.new(
      title: products(:one).title,
      description: 'dsds',
      price: 3,
      image_url: 'lorem.jpg'
    )
    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end
end
