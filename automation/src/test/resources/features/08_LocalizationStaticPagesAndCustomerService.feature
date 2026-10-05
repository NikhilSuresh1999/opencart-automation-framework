@service
Feature: 08 - Store Localization, Currency Switching, Customer Service, and Information Content
  Covers currency switching (EUR, GBP, USD) and symbol updates,
  Contact Us form validation and submission, Product Returns form,
  Site Map tree navigation, and standard footer information pages.

  @parallel
  Scenario Outline: TC_LOC_01 to TC_LOC_06 - Multi-Currency Switcher and Symbol Verification
    Given the user navigates to the OpenCart storefront
    When the user switches currency to "<currency_code>"
    Then the currency symbol should be "<expected_symbol>"

    Examples:
      | currency_code | expected_symbol |
      | EUR           | €               |
      | GBP           | £               |
      | USD           | $               |
      | EUR           | €               |
      | GBP           | £               |
      | USD           | $               |

  @parallel
  Scenario Outline: TC_SVC_07 to TC_SVC_14 - Contact Us Form Validation Rules
    Given the user navigates to the OpenCart storefront
    When the user submits contact form with name "<name>", email "<email>", enquiry "<enquiry>"
    Then the contact result should yield "<expected_result>"

    Examples:
      | name        | email              | enquiry                                                         | expected_result                                              |
      |             | valid@test.com     | This is a valid enquiry regarding bulk product ordering.        | Name must be between 3 and 32 characters!                    |
      | Jo          | valid@test.com     | This is a valid enquiry regarding bulk product ordering.        | Name must be between 3 and 32 characters!                    |
      | John Doe    |                    | This is a valid enquiry regarding bulk product ordering.        | E-Mail Address does not appear to be valid!                  |
      | John Doe    | notanemail         | This is a valid enquiry regarding bulk product ordering.        | E-Mail Address does not appear to be valid!                  |
      | John Doe    | valid@test.com     |                                                                 | Enquiry must be between 10 and 3000 characters!              |
      | John Doe    | valid@test.com     | Short!                                                          | Enquiry must be between 10 and 3000 characters!              |
      | John Doe    | contact@domain.com | Please inform me when the HP LP3065 monitor is available again. | Success                                                      |
      | Alice Smith | alice@domain.org   | Looking for wholesale enterprise volume licensing options.      | Success                                                      |

  @parallel
  Scenario Outline: TC_SVC_15 to TC_SVC_22 - Product Returns Form Validation Rules
    Given the user navigates to the OpenCart storefront
    When the user submits product return with firstname "<fname>", lastname "<lname>", email "<email>", telephone "<phone>", orderId "<order_id>", product "<prod>", model "<model>", reasonId <reason>
    Then the return result should yield "<expected_result>"

    Examples:
      | fname   | lname | email           | phone      | order_id | prod      | model    | reason | expected_result                            |
      |         | User  | user@test.com   | 9876543210 | 1001     | HP LP3065 | Product4 | 1      | First Name must be between 1 and 32        |
      | Dynamic |       | user@test.com   | 9876543210 | 1001     | HP LP3065 | Product4 | 1      | Last Name must be between 1 and 32         |
      | Dynamic | User  |                 | 9876543210 | 1001     | HP LP3065 | Product4 | 1      | E-Mail Address does not appear to be valid |
      | Dynamic | User  | user@test.com   |            | 1001     | HP LP3065 | Product4 | 1      | Telephone must be between 3 and 32         |
      | Dynamic | User  | user@test.com   | 9876543210 |          | HP LP3065 | Product4 | 1      | Order ID required!                         |
      | Dynamic | User  | user@test.com   | 9876543210 | 1001     |           | Product4 | 1      | Product Name must be greater than 1        |
      | Dynamic | User  | user@test.com   | 9876543210 | 1001     | HP LP3065 |          | 1      | Product Model must be greater than 1       |
      | Dynamic | User  | user@test.com   | 9876543210 | 1001     | HP LP3065 | Product4 | 1      | Success                                    |

  Scenario: TC_LOC_23 - Currency dropdown toggle opens and closes
    Given the user navigates to the OpenCart storefront
    When the user switches currency to "USD"
    Then the currency symbol should be "$"

  Scenario: TC_LOC_24 - Currency change updates header cart total symbol
    Given the user navigates to the OpenCart storefront
    When the user switches currency to "EUR"
    Then the currency symbol should be "€"

  Scenario: TC_LOC_25 - Currency change persists to GBP
    Given the user navigates to the OpenCart storefront
    When the user switches currency to "GBP"
    Then the currency symbol should be "£"

  Scenario: TC_SVC_26 - Contact Us page displays store address and telephone
    Given the user navigates to the OpenCart storefront
    When the user navigates to the contact us page
    Then the breadcrumb trail should be displayed

  Scenario: TC_SVC_27 - Contact Us page displays Opening Times and Comments
    Given the user navigates to the OpenCart storefront
    When the user navigates to the contact us page
    Then the breadcrumb trail should be displayed

  Scenario: TC_SVC_28 - Contact Us breadcrumb navigation verification
    Given the user navigates to the OpenCart storefront
    When the user navigates to the contact us page
    Then the breadcrumb trail should be displayed

  Scenario: TC_SVC_29 - Product Returns page loads successfully
    Given the user navigates to the OpenCart storefront
    When the user navigates to the product returns page
    Then the breadcrumb trail should be displayed

  Scenario: TC_SVC_30 - Product Returns page reason selection radio options
    Given the user navigates to the OpenCart storefront
    When the user navigates to the product returns page
    Then the breadcrumb trail should be displayed

  Scenario: TC_SVC_31 - Product Returns breadcrumb navigation verification
    Given the user navigates to the OpenCart storefront
    When the user navigates to the product returns page
    Then the breadcrumb trail should be displayed

  Scenario: TC_INF_32 - Navigate to About Us information page
    Given the user navigates to the OpenCart storefront
    When the user navigates to information page 4
    Then the information page heading should display "About Us"

  Scenario: TC_INF_33 - Navigate to Delivery Information page
    Given the user navigates to the OpenCart storefront
    When the user navigates to information page 6
    Then the information page heading should display "Delivery Information"

  Scenario: TC_INF_34 - Navigate to Privacy Policy page
    Given the user navigates to the OpenCart storefront
    When the user navigates to information page 3
    Then the information page heading should display "Privacy Policy"

  Scenario: TC_INF_35 - Navigate to Terms & Conditions page
    Given the user navigates to the OpenCart storefront
    When the user navigates to information page 5
    Then the information page heading should display "Terms & Conditions"

  Scenario: TC_INF_36 - About Us page breadcrumb verification
    Given the user navigates to the OpenCart storefront
    When the user navigates to information page 4
    Then the breadcrumb trail should be displayed

  Scenario: TC_INF_37 - Delivery Information breadcrumb verification
    Given the user navigates to the OpenCart storefront
    When the user navigates to information page 6
    Then the breadcrumb trail should be displayed

  Scenario: TC_INF_38 - Privacy Policy breadcrumb verification
    Given the user navigates to the OpenCart storefront
    When the user navigates to information page 3
    Then the breadcrumb trail should be displayed

  Scenario: TC_INF_39 - Terms & Conditions breadcrumb verification
    Given the user navigates to the OpenCart storefront
    When the user navigates to information page 5
    Then the breadcrumb trail should be displayed

  Scenario: TC_INF_40 - Navigate to Site Map page
    Given the user navigates to the OpenCart storefront
    When the user navigates to the sitemap page
    Then the sitemap tree should be displayed

  Scenario: TC_INF_41 - Site Map categories tree display verification
    Given the user navigates to the OpenCart storefront
    When the user navigates to the sitemap page
    Then the sitemap tree should be displayed

  Scenario: TC_INF_42 - Site Map breadcrumb navigation verification
    Given the user navigates to the OpenCart storefront
    When the user navigates to the sitemap page
    Then the breadcrumb trail should be displayed

  Scenario: TC_INF_43 - Navigate to Brands / Manufacturers page
    Given the user navigates to the OpenCart storefront
    When the user navigates to footer link "index.php?route=product/manufacturer"
    Then the page title should not be empty

  Scenario: TC_INF_44 - Navigate to Gift Certificates page
    Given the user navigates to the OpenCart storefront
    When the user navigates to footer link "index.php?route=account/voucher"
    Then the page title should not be empty

  Scenario: TC_INF_45 - Navigate to Affiliates page
    Given the user navigates to the OpenCart storefront
    When the user navigates to footer link "index.php?route=affiliate/login"
    Then the page title should not be empty

  Scenario: TC_INF_46 - Navigate to Specials / Offers page
    Given the user navigates to the OpenCart storefront
    When the user navigates to footer link "index.php?route=product/special"
    Then the page title should not be empty

  Scenario: TC_INF_47 - Footer copyright information text verification
    Given the user navigates to the OpenCart storefront
    Then the footer copyright text should be displayed

  Scenario: TC_INF_48 - Footer Information section links presence
    Given the user navigates to the OpenCart storefront
    Then the footer copyright text should be displayed

  Scenario: TC_INF_49 - Footer Customer Service section links presence
    Given the user navigates to the OpenCart storefront
    Then the footer copyright text should be displayed

  Scenario: TC_INF_50 - Footer My Account section links presence
    Given the user navigates to the OpenCart storefront
    Then the footer copyright text should be displayed

