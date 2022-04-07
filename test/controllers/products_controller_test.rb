# frozen_string_literal: true

require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest

  #public

  test 'should get index' do
    get products_url
    assert_response :success
  end

  test 'should show product' do
    get product_url(create(:product))
    assert_response :success
  end

  test 'should not create product if user is not logged' do
    assert_no_difference('Product.count') do
      post products_url, params: { product: attributes_for(:product) }
    end

    assert_redirected_to new_user_session_url
  end

  test 'should not delete product if user is not logged' do
    product = create(:product)
    assert_no_difference('Product.count') do
      delete product_url(product)
    end

    assert_redirected_to new_user_session_url
  end

  test 'should not update product if user is not logged' do
    product = create(:product)
    product_attr = product.attributes
    patch product_url(product), params: { product: attributes_for(:product).except(:price) }

    assert_redirected_to new_user_session_url

    product.reload

    assert_equal product_attr, product.attributes
  end

  #admin

  test 'should create product if user is admin' do
    admin = create(:user, user_role: 'admin')
    sign_in admin
    assert_difference('Product.count') do
      post products_url, params: { product: attributes_for(:product) }
    end

    assert_redirected_to product_url(Product.last)
    sign_out admin
  end

  test 'should delete product if user is admin' do
    admin = create(:user, user_role: 'admin')
    sign_in admin
    product = create(:product)
    assert_difference('Product.count',-1) do
      delete product_url(product)
    end

    assert_redirected_to products_url
    sign_out admin
  end

  test 'should update product if user is admin including price' do
    admin = create(:user, user_role: 'admin')
    sign_in admin
    product = create(:product)
    product_attr = attributes_for(:product)
    patch product_url(product), params: { product: product_attr }

    assert_redirected_to product_url(product)

    product.reload

    assert_equal product_attr, product.attributes.symbolize_keys.slice(:name,:description,:price,:stock)
    sign_out admin
  end

  #support

  test 'should not create product if user is support' do
    support = create(:user, user_role: 'support')
    sign_in support
    assert_no_difference('Product.count') do
      post products_url, params: { product: attributes_for(:product) }
    end

    assert_redirected_to products_url
    sign_out support
  end

  test 'should not delete product if user is support' do
    support = create(:user, user_role: 'support')
    sign_in support
    product = create(:product)
    assert_no_difference('Product.count') do
      delete product_url(product)
    end

    assert_redirected_to products_url
    sign_out support
  end

  test 'should update product if user is support excluding price' do
    support = create(:user, user_role: 'support')
    sign_in support
    product = create(:product)
    product_attr = attributes_for(:product).except(:price)
    patch product_url(product), params: { product: product_attr }

    assert_redirected_to product_url(product)

    product.reload

    assert_equal product_attr, product.attributes.symbolize_keys.slice(:name,:description,:stock)
    sign_out support
  end

  test 'should not update product price if user is support' do
    support = create(:user, user_role: 'support')
    sign_in support
    product = create(:product)
    initial_price = product.price
    patch product_url(product), params: { product: { price: rand(10..100.00).round(2) } }

    assert_redirected_to product_url(product)

    product.reload

    assert_equal initial_price, product.price
    sign_out support
  end

  #customer

  test 'should not create product if user is customer' do
    customer = create(:user, user_role: 'customer')
    sign_in customer
    assert_no_difference('Product.count') do
      post products_url, params: { product: attributes_for(:product) }
    end

    assert_redirected_to products_url
    sign_out customer
  end

  test 'should not delete product if user is customer' do
    customer = create(:user, user_role: 'customer')
    sign_in customer
    product = create(:product)
    assert_no_difference('Product.count') do
      delete product_url(product)
    end

    assert_redirected_to products_url
    sign_out customer
  end

  test 'should not update product if user is customer' do
    customer = create(:user, user_role: 'customer')
    sign_in customer
    product = create(:product)
    product_attr = product.attributes
    patch product_url(product), params: { product: attributes_for(:product).except(:price) }

    assert_redirected_to products_url

    product.reload

    assert_equal product_attr, product.attributes
    sign_out customer
  end

end
