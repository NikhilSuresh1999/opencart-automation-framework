@cart
Feature: 05 - Shopping Cart Management, Discount Coupons, Vouchers, and Shipping Quotes
  Covers adding products to cart, updating item quantities, item removal,
  empty cart handling, coupon code validations, gift certificate vouchers,
  and estimating shipping and tax charges.

  @parallel
  Scenario Outline: TC_CART_01 to TC_CART_10 - Add Products to Cart and Verify Badge
    Given the user navigates to the OpenCart storefront
    When the user adds product "<product_name>" to the cart with quantity "1"
    Then the cart badge should update to "1 item(s)"

    Examples:
      | product_name |
      | HP LP3065    |
      | in-stock     |
      | MacBook      |
      | iPhone       |
      | iPod Classic |
      | HTC Touch HD |
      | Palm Treo    |
      | iMac         |
      | Sony VAIO    |
      | Samsung SyncMaster |

  @parallel
  Scenario Outline: TC_CART_11 to TC_CART_18 - Coupon Code Application Edge Cases
    Given a user has an item in the cart and proceeds to checkout
    When the user navigates to the shopping cart page
    And the user applies coupon code "<coupon_code>"
    Then the cart alert should display "Warning: Coupon is either invalid, expired or reached its usage limit!"

    Examples:
      | coupon_code    |
      | INVALIDCOUPON  |
      | EXPIRED10      |
      | TEST_PROMO     |
      | DISCOUNT99     |
      | NULL_CODE      |
      | SPECIAL_OFFER  |
      | EMPTY_COUPON   |
      | 123456         |

  @parallel
  Scenario Outline: TC_CART_19 to TC_CART_26 - Gift Certificate Voucher Edge Cases
    Given a user has an item in the cart and proceeds to checkout
    When the user navigates to the shopping cart page
    And the user applies gift voucher "<voucher_code>"
    Then the cart alert should display "Warning: Gift Certificate is either invalid or the balance has been used up!"

    Examples:
      | voucher_code   |
      | INVALIDVOUCHER |
      | EXPIRED_GIFT   |
      | VOUCHER_001    |
      | NO_BALANCE     |
      | FAKE_CERT      |
      | TEST_VOUCHER   |
      | ZERO_VAL       |
      | DISCOUNT_KEY   |

  Scenario: TC_CART_27 - Shopping cart page displays added item
    Given a user has an item in the cart and proceeds to checkout
    When the user navigates to the shopping cart page
    Then the breadcrumb trail should be displayed

  Scenario: TC_CART_28 - Update item quantity in shopping cart to 2
    Given a user has an item in the cart and proceeds to checkout
    When the user navigates to the shopping cart page
    And the user updates the first cart item quantity to "2"
    Then the cart alert should display "Success: You have modified your shopping cart!"

  Scenario: TC_CART_29 - Update item quantity in shopping cart to 3
    Given a user has an item in the cart and proceeds to checkout
    When the user navigates to the shopping cart page
    And the user updates the first cart item quantity to "3"
    Then the cart alert should display "Success: You have modified your shopping cart!"

  Scenario: TC_CART_30 - Update item quantity in shopping cart to 5
    Given a user has an item in the cart and proceeds to checkout
    When the user navigates to the shopping cart page
    And the user updates the first cart item quantity to "5"
    Then the cart alert should display "Success: You have modified your shopping cart!"

  Scenario: TC_CART_31 - Remove product from cart using remove action
    Given a user has an item in the cart and proceeds to checkout
    When the user navigates to the shopping cart page
    And the user removes the first item from the cart
    Then the shopping cart should display empty message

  Scenario: TC_CART_32 - Empty cart page displays message
    Given the user navigates to the OpenCart storefront
    When the user navigates to the shopping cart page
    Then the shopping cart should display empty message

  Scenario: TC_CART_33 - Estimate shipping quotes for United States
    Given a user has an item in the cart and proceeds to checkout
    When the user navigates to the shopping cart page
    And the user estimates shipping for country "United States", zone "California", postcode "90210"
    Then the breadcrumb trail should be displayed

  Scenario: TC_CART_34 - Estimate shipping quotes for United Kingdom
    Given a user has an item in the cart and proceeds to checkout
    When the user navigates to the shopping cart page
    And the user estimates shipping for country "United Kingdom", zone "Greater London", postcode "SW1A 1AA"
    Then the breadcrumb trail should be displayed

  Scenario: TC_CART_35 - Estimate shipping quotes for Canada
    Given a user has an item in the cart and proceeds to checkout
    When the user navigates to the shopping cart page
    And the user estimates shipping for country "Canada", zone "Ontario", postcode "M5V 2T6"
    Then the breadcrumb trail should be displayed

  Scenario: TC_CART_36 - Estimate shipping quotes for Australia
    Given a user has an item in the cart and proceeds to checkout
    When the user navigates to the shopping cart page
    And the user estimates shipping for country "Australia", zone "New South Wales", postcode "2000"
    Then the breadcrumb trail should be displayed

  Scenario: TC_CART_37 - Cart totals table displays Sub-Total and Total
    Given a user has an item in the cart and proceeds to checkout
    When the user navigates to the shopping cart page
    Then the cart totals table should display sub-total and total

  Scenario: TC_CART_38 - Proceed to checkout button navigation from cart page
    Given a user has an item in the cart and proceeds to checkout
    When the user navigates to the shopping cart page
    Then the breadcrumb trail should be displayed

  Scenario: TC_CART_39 - Header cart dropdown button displays total count
    Given a user has an item in the cart and proceeds to checkout
    When the user navigates to the shopping cart page
    Then the cart badge should update to "1 item(s)"

  Scenario: TC_CART_40 - Shopping cart breadcrumb trail verification
    Given the user navigates to the OpenCart storefront
    When the user navigates to the shopping cart page
    Then the breadcrumb trail should be displayed

  Scenario: TC_CART_41 - Use coupon code accordion expands on click
    Given a user has an item in the cart and proceeds to checkout
    When the user navigates to the shopping cart page
    And the user applies coupon code "ABC"
    Then the cart alert should display "Warning: Coupon is either invalid"

  Scenario: TC_CART_42 - Use gift certificate accordion expands on click
    Given a user has an item in the cart and proceeds to checkout
    When the user navigates to the shopping cart page
    And the user applies gift voucher "XYZ"
    Then the cart alert should display "Warning: Gift Certificate is either invalid"

  Scenario: TC_CART_43 - Empty cart page continue button redirects to Home
    Given the user navigates to the OpenCart storefront
    When the user navigates to the shopping cart page
    Then the shopping cart should display empty message

  Scenario: TC_CART_44 - Cart page title verification
    Given the user navigates to the OpenCart storefront
    When the user navigates to the shopping cart page
    Then the page title should not be empty

  Scenario: TC_CART_45 - Quantity field supports single digit update
    Given a user has an item in the cart and proceeds to checkout
    When the user navigates to the shopping cart page
    And the user updates the first cart item quantity to "4"
    Then the cart alert should display "Success: You have modified your shopping cart!"

  Scenario: TC_CART_46 - Quantity field supports multi-digit update
    Given a user has an item in the cart and proceeds to checkout
    When the user navigates to the shopping cart page
    And the user updates the first cart item quantity to "12"
    Then the cart alert should display "Success: You have modified your shopping cart!"

  Scenario: TC_CART_47 - Coupon input field retains value after invalid submission
    Given a user has an item in the cart and proceeds to checkout
    When the user navigates to the shopping cart page
    And the user applies coupon code "SAVE20"
    Then the cart alert should display "Warning: Coupon is either invalid"

  Scenario: TC_CART_48 - Voucher input field retains value after invalid submission
    Given a user has an item in the cart and proceeds to checkout
    When the user navigates to the shopping cart page
    And the user applies gift voucher "GIFT100"
    Then the cart alert should display "Warning: Gift Certificate is either invalid"

  Scenario: TC_CART_49 - Direct shopping cart URL loading
    Given the user navigates to the OpenCart storefront
    When the user navigates to the shopping cart page
    Then the page title should not be empty

  Scenario: TC_CART_50 - Success banner appears when cart is modified
    Given a user has an item in the cart and proceeds to checkout
    When the user navigates to the shopping cart page
    And the user updates the first cart item quantity to "1"
    Then the cart alert should display "Success: You have modified your shopping cart!"

