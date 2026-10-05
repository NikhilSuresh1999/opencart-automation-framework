@search
Feature: 02 - Product Search Engine, Filters, and Advanced Catalog Queries
  Comprehensive test suite covering basic product search, partial matching,
  case-sensitivity, non-existent keywords, subcategory filtering,
  description search, and criteria input retention.

  @parallel
  Scenario Outline: TC_SRCH_01 to TC_SRCH_15 - Product Search by Catalog Keywords
    Given the user is on the OpenCart homepage
    When the user searches for product "<keyword>"
    Then the product grid should display "<expected_product>"

    Examples:
      | keyword         | expected_product |
      | MacBook         | MacBook          |
      | iPhone          | iPhone           |
      | Canon           | Canon            |
      | Samsung         | Samsung          |
      | Apple           | Apple            |
      | Sony            | Sony             |
      | HTC             | HTC              |
      | Palm            | Palm             |
      | HP              | HP               |
      | Nikon           | Nikon            |
      | iPod            | iPod             |
      | Touch           | Touch            |
      | Cinema          | Cinema           |
      | VAIO            | VAIO             |
      | SyncMaster      | SyncMaster       |

  @parallel
  Scenario Outline: TC_SRCH_16 to TC_SRCH_25 - Non-existent and Boundary Keywords
    Given the user is on the OpenCart homepage
    When the user searches for product "<keyword>"
    Then the product grid should display "<expected_message>"

    Examples:
      | keyword             | expected_message   |
      | InvalidProductXYZ   | No product matches |
      | 999999999           | No product matches |
      | @#$%^&*             | No product matches |
      | NonExistentBrand    | No product matches |
      | ZeroResultGadget    | No product matches |
      | RandomString12345   | No product matches |
      | UnknownDevice99     | No product matches |
      | NotInCatalog        | No product matches |
      | XXXXXXXXXXXXX       | No product matches |
      | UnmatchedSearchTerm | No product matches |

  Scenario: TC_SRCH_26 - Search with partial product keyword "Mac"
    Given the user is on the OpenCart homepage
    When the user searches for product "Mac"
    Then the product grid should display "Mac"

  Scenario: TC_SRCH_27 - Search with partial product keyword "Pho"
    Given the user is on the OpenCart homepage
    When the user searches for product "Pho"
    Then the product grid should display "iPhone"

  Scenario: TC_SRCH_28 - Search with partial product keyword "Can"
    Given the user is on the OpenCart homepage
    When the user searches for product "Can"
    Then the product grid should display "Canon"

  Scenario: TC_SRCH_29 - Case-insensitive search with lowercase "macbook"
    Given the user is on the OpenCart homepage
    When the user searches for product "macbook"
    Then the product grid should display "MacBook"

  Scenario: TC_SRCH_30 - Case-insensitive search with uppercase "MACBOOK"
    Given the user is on the OpenCart homepage
    When the user searches for product "MACBOOK"
    Then the product grid should display "MacBook"

  Scenario: TC_SRCH_31 - Search with mixed case "mAcBoOk"
    Given the user is on the OpenCart homepage
    When the user searches for product "mAcBoOk"
    Then the product grid should display "MacBook"

  Scenario: TC_SRCH_32 - Search utilizing header search button click
    Given the user is on the OpenCart homepage
    When the user searches for product "HP"
    Then the product grid should display "HP"

  Scenario: TC_SRCH_33 - Search utilizing Enter key in search box
    Given the user is on the OpenCart homepage
    When the user enters search keyword "iPhone" and presses enter
    Then the product grid should display "iPhone"

  Scenario: TC_SRCH_34 - Advanced search navigating to search results page
    Given the user is on the OpenCart homepage
    When the user navigates to the search page
    Then the breadcrumb trail should be displayed

  Scenario: TC_SRCH_35 - Search within category "Desktops"
    Given the user is on the OpenCart homepage
    When the user searches with advanced filters keyword "Mac", category "Desktops", subcategory "false", description "false"
    Then the product grid should display "Mac"

  Scenario: TC_SRCH_36 - Search within category "Laptops & Notebooks"
    Given the user is on the OpenCart homepage
    When the user searches with advanced filters keyword "HP", category "Laptops & Notebooks", subcategory "false", description "false"
    Then the product grid should display "HP"

  Scenario: TC_SRCH_37 - Search within category "Components"
    Given the user is on the OpenCart homepage
    When the user searches with advanced filters keyword "Monitor", category "Components", subcategory "true", description "false"
    Then the breadcrumb trail should be displayed

  Scenario: TC_SRCH_38 - Search within category "Tablets"
    Given the user is on the OpenCart homepage
    When the user searches with advanced filters keyword "Samsung", category "Tablets", subcategory "false", description "false"
    Then the breadcrumb trail should be displayed

  Scenario: TC_SRCH_39 - Search within category "Cameras"
    Given the user is on the OpenCart homepage
    When the user searches with advanced filters keyword "Canon", category "Cameras", subcategory "false", description "false"
    Then the product grid should display "Canon"

  Scenario: TC_SRCH_40 - Search with subcategory checkbox enabled
    Given the user is on the OpenCart homepage
    When the user searches with advanced filters keyword "Apple", category "Desktops", subcategory "true", description "false"
    Then the breadcrumb trail should be displayed

  Scenario: TC_SRCH_41 - Search with subcategory checkbox disabled
    Given the user is on the OpenCart homepage
    When the user searches with advanced filters keyword "Apple", category "Desktops", subcategory "false", description "false"
    Then the breadcrumb trail should be displayed

  Scenario: TC_SRCH_42 - Search with product description checkbox enabled
    Given the user is on the OpenCart homepage
    When the user searches with advanced filters keyword "Intel", category "All Categories", subcategory "false", description "true"
    Then the breadcrumb trail should be displayed

  Scenario: TC_SRCH_43 - Search with product description checkbox disabled
    Given the user is on the OpenCart homepage
    When the user searches with advanced filters keyword "Intel", category "All Categories", subcategory "false", description "false"
    Then the breadcrumb trail should be displayed

  Scenario: TC_SRCH_44 - Search criteria input field retains searched keyword
    Given the user is on the OpenCart homepage
    When the user searches for product "MacBook"
    Then the search criteria input should retain "MacBook"

  Scenario: TC_SRCH_45 - Search result count indicator validation
    Given the user is on the OpenCart homepage
    When the user searches for product "MacBook"
    Then the search results count should be displayed

  Scenario: TC_SRCH_46 - Search page breadcrumb trail verification
    Given the user is on the OpenCart homepage
    When the user searches for product "Canon"
    Then the breadcrumb trail should be displayed

  Scenario: TC_SRCH_47 - Search for model number "Product 15"
    Given the user is on the OpenCart homepage
    When the user searches for product "Product 15"
    Then the breadcrumb trail should be displayed

  Scenario: TC_SRCH_48 - Search for model number "Product 16"
    Given the user is on the OpenCart homepage
    When the user searches for product "Product 16"
    Then the breadcrumb trail should be displayed

  Scenario: TC_SRCH_49 - Search with leading and trailing whitespaces
    Given the user is on the OpenCart homepage
    When the user searches for product "  MacBook  "
    Then the product grid should display "MacBook"

  Scenario: TC_SRCH_50 - Direct navigation to search page with empty query parameter
    Given the user is on the OpenCart homepage
    When the user navigates to the search page
    Then the breadcrumb trail should be displayed

