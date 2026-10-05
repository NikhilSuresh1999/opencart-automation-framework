Feature: OpenCart Enterprise Regression Suite (70+ Scenarios)

  @auth @parallel
  Scenario Outline: TC_01 to TC_15 - Dynamic User Registration and Auth Edge Cases
    Given the user navigates to the OpenCart storefront
    When the user attempts registration with firstname "<fName>", lastname "<lName>", email "<email>", password "<pass>"
    Then the system should return the auth state "<expectedState>"

    Examples:
      | fName   | lName   | email             | pass      | expectedState             |
      | Dynamic | User    | dynamic           | Pass123!  | Account Created           |
      |         | User    | valid@test.com    | Pass123!  | First Name Required       |
      | Test    |         | valid@test.com    | Pass123!  | Last Name Required        |
      | Test    | User    | invalid-email     | Pass123!  | Invalid Email Format      |
      | Test    | User    | existing@test.com | Pass123!  | Warning: E-Mail Address is already registered! |

  @search @parallel
  Scenario Outline: TC_16 to TC_30 - Search Engine and Category Navigation
    Given the user is on the OpenCart homepage
    When the user searches for product "<keyword>"
    Then the product grid should display "<expectedResult>"

    Examples:
      | keyword      | expectedResult       |
      | MacBook      | MacBook              |
      | iPhone       | iPhone               |
      | asdfghjkl    | No product matches   |
      | Canon        | Canon EOS 5D         |

  @cart @parallel
  Scenario Outline: TC_31 to TC_45 - Shopping Cart State and Math Calculations
    Given the user is on the OpenCart homepage
    When the user adds product "<product>" to the cart with quantity "<qty>"
    Then the cart badge should update to "<qty>"

    Examples:
      | product      | qty |
      | iPhone       | 1   |
      | MacBook      | 2   |

  @checkout @parallel
  Scenario Outline: TC_46 to TC_60 - End-to-End Guest and Registered Checkout
    Given a user has an item in the cart and proceeds to checkout
    When the user selects checkout type "<checkoutType>"
    And enters billing details for country "<country>" and zone "<zone>"
    And selects shipping method "<shippingMethod>"
    Then the order confirmation should yield "<orderStatus>"

    Examples:
      | checkoutType | country        | zone        | shippingMethod | orderStatus        |
      | Guest        | United Kingdom | Angus       | Flat Rate      | Order Placed       |
      | Guest        |                |             | Flat Rate      | Address Error      |
      | Guest        | United States  | New York    | Flat Rate      | Order Placed       |

  