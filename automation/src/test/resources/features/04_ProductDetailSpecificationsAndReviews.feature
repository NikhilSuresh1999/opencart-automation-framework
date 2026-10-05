@product
Feature: 04 - Product Detail Specifications, Image Galleries, and Customer Reviews
  Covers product details page verification across various catalog items,
  tabbed panels (Description, Specification, Reviews), customer review submission
  and rating boundary validations, and quantity selection.

  @parallel
  Scenario Outline: TC_PROD_01 to TC_PROD_10 - Product Detail Page Views across Catalog
    Given the user navigates to the OpenCart storefront
    When the user navigates to product details with id <product_id>
    Then the product title should be displayed

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
      | 41         |
      | 48         |

  @parallel
  Scenario Outline: TC_PROD_11 to TC_PROD_20 - Customer Review Form Validations and Boundary Rules
    Given the user navigates to the OpenCart storefront
    When the user navigates to product details with id 47
    And the user submits product review with author "<author>", review "<review_text>", rating <rating>
    Then the product review alert should display "<expected_alert>"

    Examples:
      | author          | review_text                                                    | rating | expected_alert                                                 |
      |                 | This is a wonderful product with awesome build and speed.      | 5      | Warning: Review Name must be between 3 and 25 characters!      |
      | AB              | This is a wonderful product with awesome build and speed.      | 5      | Warning: Review Name must be between 3 and 25 characters!      |
      | John Doe        |                                                                | 5      | Warning: Review Text must be between 25 and 1000 characters!   |
      | John Doe        | Too short!                                                     | 5      | Warning: Review Text must be between 25 and 1000 characters!   |
      | John Doe        | This is a wonderful product with awesome build and speed.      | 0      | Warning: Please select a review rating!                        |
      | Alice Johnson   | Outstanding performance and crystal clear display resolution!  | 5      | Thank you for your review. It has been submitted               |
      | Bob Builder     | Good quality laptop with solid aluminum chassis and fast SSD.  | 4      | Thank you for your review. It has been submitted               |
      | Charlie Brown   | Average build quality for the price, battery life is okay.     | 3      | Thank you for your review. It has been submitted               |
      | David Miller    | Disappointed with the software support and driver stability.   | 2      | Thank you for your review. It has been submitted               |
      | Ethan Hunt      | Critical overheating issues experienced during heavy loads.    | 1      | Thank you for your review. It has been submitted               |

  Scenario: TC_PROD_21 - Product Description tab toggle and content visibility
    Given the user navigates to the OpenCart storefront
    When the user navigates to product details with id 47
    And the user clicks the product "Description" tab
    Then the product "Description" content should be displayed

  Scenario: TC_PROD_22 - Product Specification tab toggle and table display
    Given the user navigates to the OpenCart storefront
    When the user navigates to product details with id 47
    And the user clicks the product "Specification" tab
    Then the product specification table should be displayed

  Scenario: TC_PROD_23 - Product Reviews tab toggle and reviews form display
    Given the user navigates to the OpenCart storefront
    When the user navigates to product details with id 47
    And the user clicks the product "Reviews" tab
    Then the product "Reviews" content should be displayed

  Scenario: TC_PROD_24 - Default quantity value in quantity input is 1
    Given the user navigates to the OpenCart storefront
    When the user navigates to product details with id 47
    Then the default quantity input should be "1"

  Scenario: TC_PROD_25 - Update quantity input to 2
    Given the user navigates to the OpenCart storefront
    When the user navigates to product details with id 47
    And the user updates product quantity to "2"
    Then the default quantity input should be "2"

  Scenario: TC_PROD_26 - Update quantity input to 5
    Given the user navigates to the OpenCart storefront
    When the user navigates to product details with id 47
    And the user updates product quantity to "5"
    Then the default quantity input should be "5"

  Scenario: TC_PROD_27 - Update quantity input to 10
    Given the user navigates to the OpenCart storefront
    When the user navigates to product details with id 47
    And the user updates product quantity to "10"
    Then the default quantity input should be "10"

  Scenario: TC_PROD_28 - Add product to cart with updated quantity
    Given the user navigates to the OpenCart storefront
    When the user navigates to product details with id 47
    And the user updates product quantity to "2"
    And the user clicks add to cart on product detail page
    Then the product detail alert should display "Success: You have added"

  Scenario: TC_PROD_29 - Add product to cart directly from product page
    Given the user navigates to the OpenCart storefront
    When the user navigates to product details with id 47
    And the user clicks add to cart on product detail page
    Then the product detail alert should display "Success: You have added"

  Scenario: TC_PROD_30 - Add product to wishlist from product detail page
    Given the user navigates to the OpenCart storefront
    When the user navigates to product details with id 47
    And the user clicks add to wishlist on product detail page
    Then the product detail alert should display "You must login or create an account"

  Scenario: TC_PROD_31 - Add product to compare from product detail page
    Given the user navigates to the OpenCart storefront
    When the user navigates to product details with id 47
    And the user clicks compare on product detail page
    Then the product detail alert should display "Success: You have added"

  Scenario: TC_PROD_32 - Product detail breadcrumb navigation trail verification
    Given the user navigates to the OpenCart storefront
    When the user navigates to product details with id 47
    Then the breadcrumb trail should be displayed

  Scenario: TC_PROD_33 - Review author field boundary minimum 3 characters validation
    Given the user navigates to the OpenCart storefront
    When the user navigates to product details with id 47
    And the user submits product review with author "Jo", review "This is a great product with solid build and long battery life.", rating 5
    Then the product review alert should display "Warning: Review Name must be between 3 and 25 characters!"

  Scenario: TC_PROD_34 - Review author field boundary maximum 25 characters validation
    Given the user navigates to the OpenCart storefront
    When the user navigates to product details with id 47
    And the user submits product review with author "ThisNameIsFarTooLongForValidation", review "This is a great product with solid build and long battery life.", rating 5
    Then the product review alert should display "Warning: Review Name must be between 3 and 25 characters!"

  Scenario: TC_PROD_35 - Review text field boundary minimum 25 characters validation
    Given the user navigates to the OpenCart storefront
    When the user navigates to product details with id 47
    And the user submits product review with author "John", review "Short review text.", rating 5
    Then the product review alert should display "Warning: Review Text must be between 25 and 1000 characters!"

  Scenario: TC_PROD_36 - Review submission rating selection validation
    Given the user navigates to the OpenCart storefront
    When the user navigates to product details with id 47
    And the user submits product review with author "John Doe", review "Excellent performance and build quality across daily operations.", rating 0
    Then the product review alert should display "Warning: Please select a review rating!"

  Scenario: TC_PROD_37 - Valid review submission with 5-star rating
    Given the user navigates to the OpenCart storefront
    When the user navigates to product details with id 47
    And the user submits product review with author "Tester Pro", review "Superb workstation monitor with rich vivid colors and sharp text.", rating 5
    Then the product review alert should display "Thank you for your review."

  Scenario: TC_PROD_38 - Valid review submission with 4-star rating
    Given the user navigates to the OpenCart storefront
    When the user navigates to product details with id 47
    And the user submits product review with author "Tester Pro", review "Great display quality though standby power consumption could improve.", rating 4
    Then the product review alert should display "Thank you for your review."

  Scenario: TC_PROD_39 - Valid review submission with 3-star rating
    Given the user navigates to the OpenCart storefront
    When the user navigates to product details with id 47
    And the user submits product review with author "Tester Pro", review "Decent value product, meets standard expectations for office work.", rating 3
    Then the product review alert should display "Thank you for your review."

  Scenario: TC_PROD_40 - Valid review submission with 2-star rating
    Given the user navigates to the OpenCart storefront
    When the user navigates to product details with id 47
    And the user submits product review with author "Tester Pro", review "Subpar performance and inconsistent brightness across screen corners.", rating 2
    Then the product review alert should display "Thank you for your review."

  Scenario: TC_PROD_41 - Valid review submission with 1-star rating
    Given the user navigates to the OpenCart storefront
    When the user navigates to product details with id 47
    And the user submits product review with author "Tester Pro", review "Defective unit received with dead pixels and unresponsive buttons.", rating 1
    Then the product review alert should display "Thank you for your review."

  Scenario: TC_PROD_42 - Direct product URL loading via product route and ID
    Given the user navigates to the OpenCart storefront
    When the user navigates to product details with id 43
    Then the product title should be displayed

  Scenario: TC_PROD_43 - Product details page displays pricing information
    Given the user navigates to the OpenCart storefront
    When the user navigates to product details with id 47
    Then the breadcrumb trail should be displayed

  Scenario: TC_PROD_44 - Product details page displays stock availability status
    Given the user navigates to the OpenCart storefront
    When the user navigates to product details with id 47
    Then the breadcrumb trail should be displayed

  Scenario: TC_PROD_45 - Product details page meta title verification
    Given the user navigates to the OpenCart storefront
    When the user navigates to product details with id 47
    Then the page title should not be empty

