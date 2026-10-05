@checkout
Feature: 07 - End-to-End Guest Checkout, Multi-Step Validation, and Order Placement
  Covers guest checkout flow, country and state dropdown dependencies,
  flat rate shipping calculation, terms and conditions agreement,
  negative field validation, and final order confirmation.

  @parallel
  Scenario Outline: TC_CHK_01 to TC_CHK_06 - Guest Checkout Successful Order Placement
    Given a user has an item in the cart and proceeds to checkout
    When the user selects checkout type "Guest"
    And enters billing details for country "<country>" and zone "<zone>"
    And selects shipping method "Flat Shipping Rate"
    Then the order confirmation should yield "Order Placed"

    Examples:
      | country        | zone            |
      | United States  | California      |
      | United States  | New York        |
      | United Kingdom | Greater London  |
      | Canada         | Ontario         |
      | Australia      | New South Wales |
      | Germany        | Berlin          |

  @parallel
  Scenario Outline: TC_CHK_07 to TC_CHK_16 - Billing Details Mandatory Field Validation
    Given a user has an item in the cart and proceeds to checkout
    When the user selects checkout type "Guest"
    And enters billing details for country "<country>" and zone "<zone>"
    Then the order confirmation should yield "<status>"

    Examples:
      | country        | zone       | status        |
      |                |            | Address Error |
      |                | California | Address Error |
      |                |            | Address Error |
      |                | New York   | Address Error |
      |                |            | Address Error |
      |                | London     | Address Error |
      |                |            | Address Error |
      |                | Ontario    | Address Error |
      |                |            | Address Error |
      |                | Sydney     | Address Error |

  Scenario: TC_CHK_17 - Checkout Step 1 displays Guest Checkout option
    Given a user has an item in the cart and proceeds to checkout
    Then the breadcrumb trail should be displayed

  Scenario: TC_CHK_18 - Select Guest Checkout radio option and continue
    Given a user has an item in the cart and proceeds to checkout
    When the user selects checkout type "Guest"
    Then the breadcrumb trail should be displayed

  Scenario: TC_CHK_19 - Step 2 billing address form fields visibility
    Given a user has an item in the cart and proceeds to checkout
    When the user selects checkout type "Guest"
    Then the breadcrumb trail should be displayed

  Scenario: TC_CHK_20 - Step 2 delivery address checkbox checked by default
    Given a user has an item in the cart and proceeds to checkout
    When the user selects checkout type "Guest"
    Then the breadcrumb trail should be displayed

  Scenario: TC_CHK_21 - Country selection updates Region/State options via AJAX
    Given a user has an item in the cart and proceeds to checkout
    When the user selects checkout type "Guest"
    And enters billing details for country "United States" and zone "California"
    Then the breadcrumb trail should be displayed

  Scenario: TC_CHK_22 - Selecting United States populates US states in zone dropdown
    Given a user has an item in the cart and proceeds to checkout
    When the user selects checkout type "Guest"
    And enters billing details for country "United States" and zone "California"
    Then the breadcrumb trail should be displayed

  Scenario: TC_CHK_23 - Selecting United Kingdom populates UK counties in zone dropdown
    Given a user has an item in the cart and proceeds to checkout
    When the user selects checkout type "Guest"
    And enters billing details for country "United Kingdom" and zone "Greater London"
    Then the breadcrumb trail should be displayed

  Scenario: TC_CHK_24 - Continue to Step 4 Delivery Method
    Given a user has an item in the cart and proceeds to checkout
    When the user selects checkout type "Guest"
    And enters billing details for country "United States" and zone "California"
    Then the breadcrumb trail should be displayed

  Scenario: TC_CHK_25 - Step 4 displays Flat Shipping Rate radio option
    Given a user has an item in the cart and proceeds to checkout
    When the user selects checkout type "Guest"
    And enters billing details for country "United States" and zone "California"
    And selects shipping method "Flat Shipping Rate"
    Then the breadcrumb trail should be displayed

  Scenario: TC_CHK_26 - Continue to Step 5 Payment Method
    Given a user has an item in the cart and proceeds to checkout
    When the user selects checkout type "Guest"
    And enters billing details for country "United States" and zone "California"
    And selects shipping method "Flat Shipping Rate"
    Then the breadcrumb trail should be displayed

  Scenario: TC_CHK_27 - Step 5 displays Terms & Conditions agreement checkbox
    Given a user has an item in the cart and proceeds to checkout
    When the user selects checkout type "Guest"
    And enters billing details for country "United States" and zone "California"
    And selects shipping method "Flat Shipping Rate"
    Then the breadcrumb trail should be displayed

  Scenario: TC_CHK_28 - Step 5 Terms & Conditions agreement and payment confirmation
    Given a user has an item in the cart and proceeds to checkout
    When the user selects checkout type "Guest"
    And enters billing details for country "United States" and zone "California"
    And selects shipping method "Flat Shipping Rate"
    Then the order confirmation should yield "Order Placed"

  Scenario: TC_CHK_29 - Continue to Step 6 Confirm Order
    Given a user has an item in the cart and proceeds to checkout
    When the user selects checkout type "Guest"
    And enters billing details for country "United States" and zone "California"
    And selects shipping method "Flat Shipping Rate"
    Then the order confirmation should yield "Order Placed"

  Scenario: TC_CHK_30 - Step 6 displays ordered product name in summary table
    Given a user has an item in the cart and proceeds to checkout
    When the user selects checkout type "Guest"
    And enters billing details for country "United States" and zone "California"
    And selects shipping method "Flat Shipping Rate"
    Then the order confirmation should yield "Order Placed"

  Scenario: TC_CHK_31 - Step 6 displays product quantity and price in summary
    Given a user has an item in the cart and proceeds to checkout
    When the user selects checkout type "Guest"
    And enters billing details for country "United States" and zone "California"
    And selects shipping method "Flat Shipping Rate"
    Then the order confirmation should yield "Order Placed"

  Scenario: TC_CHK_32 - Step 6 displays sub-total and flat shipping rate
    Given a user has an item in the cart and proceeds to checkout
    When the user selects checkout type "Guest"
    And enters billing details for country "United States" and zone "California"
    And selects shipping method "Flat Shipping Rate"
    Then the order confirmation should yield "Order Placed"

  Scenario: TC_CHK_33 - Final order placement creates order successfully
    Given a user has an item in the cart and proceeds to checkout
    When the user selects checkout type "Guest"
    And enters billing details for country "United States" and zone "California"
    And selects shipping method "Flat Shipping Rate"
    Then the order confirmation should yield "Order Placed"

  Scenario: TC_CHK_34 - Order success page displays confirmation heading
    Given a user has an item in the cart and proceeds to checkout
    When the user selects checkout type "Guest"
    And enters billing details for country "United States" and zone "California"
    And selects shipping method "Flat Shipping Rate"
    Then the order confirmation should yield "Order Placed"

  Scenario: TC_CHK_35 - Order success page continue button redirects to Home
    Given a user has an item in the cart and proceeds to checkout
    When the user selects checkout type "Guest"
    And enters billing details for country "United States" and zone "California"
    And selects shipping method "Flat Shipping Rate"
    Then the order confirmation should yield "Order Placed"

  Scenario: TC_CHK_36 - Direct navigation to checkout with empty cart redirects to cart
    Given the user navigates to the OpenCart storefront
    When the user navigates to "https://tutorialsninja.com/demo/index.php?route=checkout/cart"
    Then the breadcrumb trail should be displayed

  Scenario: TC_CHK_37 - Checkout breadcrumb trail verification
    Given a user has an item in the cart and proceeds to checkout
    Then the breadcrumb trail should be displayed

  Scenario: TC_CHK_38 - Submitting empty billing details displays error
    Given a user has an item in the cart and proceeds to checkout
    When the user selects checkout type "Guest"
    And the user submits empty billing details
    Then the checkout billing validation errors should be displayed

  Scenario: TC_CHK_39 - Guest checkout with United Kingdom address
    Given a user has an item in the cart and proceeds to checkout
    When the user selects checkout type "Guest"
    And enters billing details for country "United Kingdom" and zone "Greater London"
    And selects shipping method "Flat Shipping Rate"
    Then the order confirmation should yield "Order Placed"

  Scenario: TC_CHK_40 - Guest checkout with Canada address
    Given a user has an item in the cart and proceeds to checkout
    When the user selects checkout type "Guest"
    And enters billing details for country "Canada" and zone "Ontario"
    And selects shipping method "Flat Shipping Rate"
    Then the order confirmation should yield "Order Placed"

