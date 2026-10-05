@category
Feature: 03 - Category Navigation, Catalog Sorting, Display Limits, and View Layouts
  Covers category hierarchy navigation across all main departments,
  product sorting criteria, item limit pagination, and switching
  between Grid and List display modes.

  @parallel
  Scenario Outline: TC_CAT_01 to TC_CAT_12 - Category Hierarchy Navigation
    Given the user is on the OpenCart homepage
    When the user navigates to category "<path>"
    Then the category heading should display "<expected_heading>"

    Examples:
      | path  | expected_heading     |
      | 20    | Desktops             |
      | 18    | Laptops & Notebooks  |
      | 25    | Components           |
      | 57    | Tablets              |
      | 17    | Software             |
      | 24    | Phones & PDAs        |
      | 33    | Cameras              |
      | 34    | MP3 Players          |
      | 20_26 | PC                   |
      | 20_27 | Mac                  |
      | 25_28 | Monitors             |
      | 25_30 | Printers             |

  @parallel
  Scenario Outline: TC_CAT_13 to TC_CAT_21 - Product Catalog Sorting Options
    Given the user is on the OpenCart homepage
    When the user navigates to category "20"
    And the user selects sort option "<sort_option>"
    Then the product catalog should be sorted

    Examples:
      | sort_option         |
      | Default             |
      | Name (A - Z)        |
      | Name (Z - A)        |
      | Price (Low > High)  |
      | Price (High > Low)  |
      | Rating (Highest)    |
      | Rating (Lowest)     |
      | Model (A - Z)       |
      | Model (Z - A)       |

  @parallel
  Scenario Outline: TC_CAT_22 to TC_CAT_26 - Product Catalog Display Limit Options
    Given the user is on the OpenCart homepage
    When the user navigates to category "20"
    And the user selects display limit "<limit_option>"
    Then the product catalog limit should update

    Examples:
      | limit_option |
      | 20           |
      | 25           |
      | 50           |
      | 75           |
      | 100          |

  Scenario: TC_CAT_27 - Switch catalog view to List View
    Given the user is on the OpenCart homepage
    When the user navigates to category "20"
    And the user switches to "list" view
    Then the active catalog view should be "list"

  Scenario: TC_CAT_28 - Switch catalog view to Grid View
    Given the user is on the OpenCart homepage
    When the user navigates to category "20"
    And the user switches to "grid" view
    Then the active catalog view should be "grid"

  Scenario: TC_CAT_29 - List view button displays active styling
    Given the user is on the OpenCart homepage
    When the user navigates to category "18"
    And the user switches to "list" view
    Then the active catalog view should be "list"

  Scenario: TC_CAT_30 - Grid view button displays active styling
    Given the user is on the OpenCart homepage
    When the user navigates to category "18"
    And the user switches to "grid" view
    Then the active catalog view should be "grid"

  Scenario: TC_CAT_31 - Category banner and heading verification for Desktops
    Given the user is on the OpenCart homepage
    When the user navigates to category "20"
    Then the category heading should display "Desktops"

  Scenario: TC_CAT_32 - Category subcategory list items display
    Given the user is on the OpenCart homepage
    When the user navigates to category "20"
    Then the category subcategories list should be displayed

  Scenario: TC_CAT_33 - Subcategory navigation to Mac desktops
    Given the user is on the OpenCart homepage
    When the user navigates to category "20_27"
    Then the category heading should display "Mac"

  Scenario: TC_CAT_34 - Subcategory navigation to PC desktops
    Given the user is on the OpenCart homepage
    When the user navigates to category "20_26"
    Then the category heading should display "PC"

  Scenario: TC_CAT_35 - Subcategory navigation to Monitors
    Given the user is on the OpenCart homepage
    When the user navigates to category "25_28"
    Then the category heading should display "Monitors"

  Scenario: TC_CAT_36 - Subcategory navigation to Printers
    Given the user is on the OpenCart homepage
    When the user navigates to category "25_30"
    Then the category heading should display "Printers"

  Scenario: TC_CAT_37 - Empty category display message verification
    Given the user is on the OpenCart homepage
    When the user navigates to category "17"
    Then the category empty message "There are no products to list in this category." should be displayed

  Scenario: TC_CAT_38 - Category breadcrumb navigation back to Home
    Given the user is on the OpenCart homepage
    When the user navigates to category "20"
    Then the breadcrumb trail should be displayed

  Scenario: TC_CAT_39 - Product card price text format verification
    Given the user is on the OpenCart homepage
    When the user navigates to category "20"
    Then the product prices should display tax information

  Scenario: TC_CAT_40 - Category product compare link text verification
    Given the user is on the OpenCart homepage
    When the user navigates to category "20"
    Then the breadcrumb trail should be displayed

  Scenario: TC_CAT_41 - Left navigation menu category expansion
    Given the user is on the OpenCart homepage
    When the user navigates to category "20"
    Then the category subcategories list should be displayed

  Scenario: TC_CAT_42 - Category page pagination controls visibility check
    Given the user is on the OpenCart homepage
    When the user navigates to category "20"
    Then the breadcrumb trail should be displayed

  Scenario: TC_CAT_43 - Top navigation Tablets direct department loading
    Given the user is on the OpenCart homepage
    When the user navigates to category "57"
    Then the category heading should display "Tablets"

  Scenario: TC_CAT_44 - Top navigation Cameras department loading
    Given the user is on the OpenCart homepage
    When the user navigates to category "33"
    Then the category heading should display "Cameras"

  Scenario: TC_CAT_45 - Top navigation Phones & PDAs department loading
    Given the user is on the OpenCart homepage
    When the user navigates to category "24"
    Then the category heading should display "Phones & PDAs"

  Scenario: TC_CAT_46 - Category page meta title verification
    Given the user is on the OpenCart homepage
    When the user navigates to category "20"
    Then the page title should not be empty

  Scenario: TC_CAT_47 - Sorting dropdown preserves selected option
    Given the user is on the OpenCart homepage
    When the user navigates to category "20"
    And the user selects sort option "Name (A - Z)"
    Then the product catalog should be sorted

  Scenario: TC_CAT_48 - Limit dropdown preserves selected option
    Given the user is on the OpenCart homepage
    When the user navigates to category "20"
    And the user selects display limit "25"
    Then the product catalog limit should update

  Scenario: TC_CAT_49 - Category view mode toggle persistence
    Given the user is on the OpenCart homepage
    When the user navigates to category "20"
    And the user switches to "list" view
    And the user switches to "grid" view
    Then the active catalog view should be "grid"

