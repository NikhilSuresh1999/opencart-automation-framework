@wishlist
Feature: 06 - Customer Wishlist and Side-by-Side Product Comparison
  Covers guest user wishlist prompts requiring authentication,
  adding catalog products to comparison, viewing comparison table specifications,
  and removing items from comparison.

  @parallel
  Scenario Outline: TC_WSH_01 to TC_WSH_08 - Add to Wishlist as Guest User
    Given the user navigates to the OpenCart storefront
    When the user adds product id <product_id> to wishlist as guest
    Then the wishlist alert should indicate login required

    Examples:
      | product_id |
      | 47         |
      | 43         |
      | 40         |
      | 30         |
      | 42         |
      | 33         |
      | 46         |
      | 28         |

  @parallel
  Scenario Outline: TC_CMP_09 to TC_CMP_16 - Add Products to Comparison
    Given the user navigates to the OpenCart storefront
    When the user adds product id <product_id> to comparison
    Then the comparison alert should display success

    Examples:
      | product_id |
      | 47         |
      | 43         |
      | 40         |
      | 30         |
      | 42         |
      | 33         |
      | 46         |
      | 28         |

  Scenario: TC_WSH_17 - Wishlist header link text displays item counter
    Given the user navigates to the OpenCart storefront
    When the user adds product id 47 to wishlist as guest
    Then the breadcrumb trail should be displayed

  Scenario: TC_WSH_18 - Clicking wishlist link as guest redirects to Login page
    Given the user navigates to the OpenCart storefront
    When the user navigates to "https://tutorialsninja.com/demo/index.php?route=account/wishlist"
    Then the user should be redirected to login page

  Scenario: TC_WSH_19 - Wishlist alert notification contains login link
    Given the user navigates to the OpenCart storefront
    When the user adds product id 47 to wishlist as guest
    Then the wishlist alert should indicate login required

  Scenario: TC_WSH_20 - Wishlist alert notification contains create an account link
    Given the user navigates to the OpenCart storefront
    When the user adds product id 47 to wishlist as guest
    Then the wishlist alert should indicate login required

  Scenario: TC_WSH_21 - Wishlist alert notification contains product name link
    Given the user navigates to the OpenCart storefront
    When the user adds product id 47 to wishlist as guest
    Then the wishlist alert should indicate login required

  Scenario: TC_WSH_22 - Wishlist action from product details page
    Given the user navigates to the OpenCart storefront
    When the user navigates to product details with id 47
    And the user clicks add to wishlist on product detail page
    Then the wishlist alert should indicate login required

  Scenario: TC_CMP_23 - Comparison banner contains link to product comparison
    Given the user navigates to the OpenCart storefront
    When the user adds product id 47 to comparison
    Then the comparison alert should display success

  Scenario: TC_CMP_24 - Navigate to product comparison page
    Given the user navigates to the OpenCart storefront
    When the user adds product id 47 to comparison
    And the user navigates to the product comparison page
    Then the product comparison table should be displayed

  Scenario: TC_CMP_25 - Comparison table displays product name
    Given the user navigates to the OpenCart storefront
    When the user adds product id 47 to comparison
    And the user navigates to the product comparison page
    Then the product comparison table should be displayed

  Scenario: TC_CMP_26 - Comparison table displays product image
    Given the user navigates to the OpenCart storefront
    When the user adds product id 47 to comparison
    And the user navigates to the product comparison page
    Then the product comparison table should be displayed

  Scenario: TC_CMP_27 - Comparison table displays product price
    Given the user navigates to the OpenCart storefront
    When the user adds product id 47 to comparison
    And the user navigates to the product comparison page
    Then the product comparison table should be displayed

  Scenario: TC_CMP_28 - Comparison table displays product model
    Given the user navigates to the OpenCart storefront
    When the user adds product id 47 to comparison
    And the user navigates to the product comparison page
    Then the product comparison table should be displayed

  Scenario: TC_CMP_29 - Comparison table displays product brand
    Given the user navigates to the OpenCart storefront
    When the user adds product id 47 to comparison
    And the user navigates to the product comparison page
    Then the product comparison table should be displayed

  Scenario: TC_CMP_30 - Comparison table displays product availability
    Given the user navigates to the OpenCart storefront
    When the user adds product id 47 to comparison
    And the user navigates to the product comparison page
    Then the product comparison table should be displayed

  Scenario: TC_CMP_31 - Comparison table displays product rating
    Given the user navigates to the OpenCart storefront
    When the user adds product id 47 to comparison
    And the user navigates to the product comparison page
    Then the product comparison table should be displayed

  Scenario: TC_CMP_32 - Comparison table displays product summary description
    Given the user navigates to the OpenCart storefront
    When the user adds product id 47 to comparison
    And the user navigates to the product comparison page
    Then the product comparison table should be displayed

  Scenario: TC_CMP_33 - Comparison table displays product weight and dimensions
    Given the user navigates to the OpenCart storefront
    When the user adds product id 47 to comparison
    And the user navigates to the product comparison page
    Then the product comparison table should be displayed

  Scenario: TC_CMP_34 - Remove product from comparison table
    Given the user navigates to the OpenCart storefront
    When the user adds product id 47 to comparison
    And the user navigates to the product comparison page
    And the user removes a product from the comparison table
    Then the product comparison page should display empty message

  Scenario: TC_CMP_35 - Empty comparison page displays message
    Given the user navigates to the OpenCart storefront
    When the user navigates to the product comparison page
    Then the product comparison page should display empty message

  Scenario: TC_CMP_36 - Empty comparison continue button redirects to Home
    Given the user navigates to the OpenCart storefront
    When the user navigates to the product comparison page
    Then the product comparison page should display empty message

  Scenario: TC_CMP_37 - Compare two products side by side
    Given the user navigates to the OpenCart storefront
    When the user adds product id 47 to comparison
    And the user adds product id 43 to comparison
    And the user navigates to the product comparison page
    Then the product comparison table should be displayed

  Scenario: TC_CMP_38 - Product comparison breadcrumb verification
    Given the user navigates to the OpenCart storefront
    When the user navigates to the product comparison page
    Then the breadcrumb trail should be displayed

  Scenario: TC_CMP_39 - Header comparison counter update
    Given the user navigates to the OpenCart storefront
    When the user adds product id 47 to comparison
    Then the comparison alert should display success

  Scenario: TC_CMP_40 - Product comparison page title verification
    Given the user navigates to the OpenCart storefront
    When the user navigates to the product comparison page
    Then the page title should not be empty

  Scenario: TC_CMP_41 - Comparison action from product detail page
    Given the user navigates to the OpenCart storefront
    When the user navigates to product details with id 43
    And the user clicks compare on product detail page
    Then the comparison alert should display success

  Scenario: TC_CMP_42 - Clear all items from comparison
    Given the user navigates to the OpenCart storefront
    When the user adds product id 47 to comparison
    And the user navigates to the product comparison page
    And the user removes a product from the comparison table
    Then the product comparison page should display empty message

