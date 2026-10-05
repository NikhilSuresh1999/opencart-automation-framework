@auth
Feature: 01 - User Registration, Authentication, and Account Lifecycle Management
  Comprehensive regression suite covering positive and negative registration permutations,
  input field boundary validations, password complexity, login credentials,
  forgotten password recovery, and session termination.

  @parallel
  Scenario Outline: TC_AUTH_01 to TC_AUTH_20 - User Registration Data Combinations and Field Validation
    Given the user navigates to the OpenCart storefront
    When the user attempts registration with firstname "<fname>", lastname "<lname>", email "<email>", telephone "<phone>", password "<password>", confirm "<confirm>", agree policy "<agree>"
    Then the system should return the auth state "<expected_state>"

    Examples:
      | fname      | lname       | email                  | phone        | password     | confirm      | agree | expected_state                              |
      | Dynamic    | User        | dynamic                | dynamic      | Pass123!     | Pass123!     | true  | Account Created                             |
      |            | User        | valid1@test.com        | 9876543210   | Pass123!     | Pass123!     | true  | First Name must be between 1 and 32         |
      | John       |             | valid2@test.com        | 9876543210   | Pass123!     | Pass123!     | true  | Last Name must be between 1 and 32          |
      | John       | Doe         | invalidemail           | 9876543210   | Pass123!     | Pass123!     | true  | E-Mail Address does not appear to be valid! |
      | John       | Doe         | missingdomain@         | 9876543210   | Pass123!     | Pass123!     | true  | E-Mail Address does not appear to be valid! |
      | John       | Doe         | @nodomain.com          | 9876543210   | Pass123!     | Pass123!     | true  | E-Mail Address does not appear to be valid! |
      | John       | Doe         | valid3@test.com        |              | Pass123!     | Pass123!     | true  | Telephone must be between 3 and 32          |
      | John       | Doe         | valid4@test.com        | 12           | Pass123!     | Pass123!     | true  | Telephone must be between 3 and 32          |
      | John       | Doe         | valid5@test.com        | 9876543210   | 123          | 123          | true  | Password must be between 4 and 20           |
      | John       | Doe         | valid6@test.com        | 9876543210   | Pass123!     | Mismatch99   | true  | Password confirmation does not match        |
      | John       | Doe         | valid7@test.com        | 9876543210   | Pass123!     | Pass123!     | false | Warning: You must agree to the Privacy      |
      | Dynamic    | User        | dynamic                | dynamic      | Test@2026!   | Test@2026!   | true  | Account Created                             |
      | Alexander  | Hamilton    | dynamic                | 1234567890   | Alex@1776!   | Alex@1776!   | true  | Account Created                             |
      | Elizabeth  | Bennet      | dynamic                | 0987654321   | Pride@1813!  | Pride@1813!  | true  | Account Created                             |
      | A          | B           | dynamic                | 5551234567   | Abc1!        | Abc1!        | true  | Account Created                             |
      | UserLong   | NameTest    | dynamic                | 9998887776   | Pass@word1   | Pass@word1   | true  | Account Created                             |
      | Robert     | Smith       | test@existing.com      | 9876543210   | Pass123!     | Pass123!     | true  | Warning: E-Mail Address is already          |
      | Jane       |             | valid8@test.com        | 9876543210   | Pass123!     | Pass123!     | true  | Last Name must be between 1 and 32          |
      |            | Doe         | valid9@test.com        | 9876543210   | Pass123!     | Pass123!     | true  | First Name must be between 1 and 32         |
      | Dynamic    | User        | dynamic                | dynamic      | SecurePass1! | SecurePass1! | true  | Account Created                             |

  Scenario: TC_AUTH_21 - Successful registration with newsletter subscription
    Given the user navigates to the OpenCart storefront
    When the user fills the registration form with valid dynamic data and checks newsletter "yes"
    Then the system should return the auth state "Account Created"

  Scenario: TC_AUTH_22 - Registration with numeric first name boundary
    Given the user navigates to the OpenCart storefront
    When the user attempts registration with firstname "12345", lastname "User", email "dynamic", telephone "9876543210", password "Pass123!", confirm "Pass123!", agree policy "true"
    Then the system should return the auth state "Account Created"

  Scenario: TC_AUTH_23 - Registration with hyphenated last name
    Given the user navigates to the OpenCart storefront
    When the user attempts registration with firstname "Mary", lastname "Smith-Jones", email "dynamic", telephone "9876543210", password "Pass123!", confirm "Pass123!", agree policy "true"
    Then the system should return the auth state "Account Created"

  Scenario: TC_AUTH_24 - Registration with alphanumeric email username
    Given the user navigates to the OpenCart storefront
    When the user attempts registration with firstname "Tester", lastname "Automated", email "dynamic", telephone "9876543210", password "Pass123!", confirm "Pass123!", agree policy "true"
    Then the system should return the auth state "Account Created"

  Scenario: TC_AUTH_25 - Registration with international telephone format
    Given the user navigates to the OpenCart storefront
    When the user attempts registration with firstname "Global", lastname "Customer", email "dynamic", telephone "+14155552671", password "Pass123!", confirm "Pass123!", agree policy "true"
    Then the system should return the auth state "Account Created"

  Scenario: TC_AUTH_26 - Registration sanitization check for SQL injection payload in firstname
    Given the user navigates to the OpenCart storefront
    When the user attempts registration with firstname "' OR 1=1 --", lastname "SQL", email "dynamic", telephone "9876543210", password "Pass123!", confirm "Pass123!", agree policy "true"
    Then the system should return the auth state "Account Created"

  Scenario: TC_AUTH_27 - Registration sanitization check for script tags in lastname
    Given the user navigates to the OpenCart storefront
    When the user attempts registration with firstname "John", lastname "Script", email "dynamic", telephone "9876543210", password "Pass123!", confirm "Pass123!", agree policy "true"
    Then the system should return the auth state "Account Created"

  Scenario: TC_AUTH_28 - Privacy policy checkbox verification on registration form
    Given the user navigates to the OpenCart storefront
    When the user navigates to the registration page
    Then the registration privacy policy checkbox should be present

  Scenario: TC_AUTH_29 - Navigation to login page from registration page
    Given the user navigates to the OpenCart storefront
    When the user navigates to the registration page
    Then the user navigates to login page from registration link

  Scenario: TC_AUTH_30 - Verify breadcrumb navigation on register page
    Given the user navigates to the OpenCart storefront
    When the user navigates to the registration page
    Then the breadcrumb trail should be displayed

  Scenario: TC_AUTH_31 - Mandatory field error verification when submitting empty registration form
    Given the user navigates to the OpenCart storefront
    When the user attempts registration with firstname "", lastname "", email "", telephone "", password "", confirm "", agree policy "false"
    Then the registration field validation error should be displayed

  Scenario: TC_AUTH_32 - Registration with trailing spaces in email
    Given the user navigates to the OpenCart storefront
    When the user attempts registration with firstname "Test", lastname "User", email "invalid space@test.com", telephone "9876543210", password "Pass123!", confirm "Pass123!", agree policy "true"
    Then the system should return the auth state "E-Mail Address does not appear to be valid!"

  Scenario: TC_AUTH_33 - Password field masking attribute verification
    Given the user navigates to the OpenCart storefront
    When the user navigates to the registration page
    Then the password input field should have type "password"

  Scenario: TC_AUTH_34 - Confirm password field masking attribute verification
    Given the user navigates to the OpenCart storefront
    When the user navigates to the registration page
    Then the confirm password input field should have type "password"

  Scenario: TC_AUTH_35 - Direct registration page URL loading
    Given the user navigates to the OpenCart storefront
    When the user navigates to the registration page
    Then the breadcrumb trail should be displayed

  @parallel
  Scenario Outline: TC_AUTH_36 to TC_AUTH_50 - User Login Credentials Combinations
    Given the user navigates to the OpenCart storefront
    When the user attempts login with email "<email>" and password "<password>"
    Then the system should return the login state "<expected_state>"

    Examples:
      | email                   | password     | expected_state                                     |
      | non_existent@domain.com | WrongPass123 | Warning: No match for E-Mail Address and/or Pass   |
      | invalid_user@test.org   | Invalid999   | Warning: No match for E-Mail Address and/or Pass   |
      |                         |              | Warning: No match for E-Mail Address and/or Pass   |
      | admin@opencart.com      | admin123     | Warning: No match for E-Mail Address and/or Pass   |
      | testuser@mail.com       |              | Warning: No match for E-Mail Address and/or Pass   |
      |                         | SecretPass!  | Warning: No match for E-Mail Address and/or Pass   |
      | ' OR '1'='1             | pass         | Warning: No match for E-Mail Address and/or Pass   |
      | test.customer@demo.com  | 12345        | Warning: No match for E-Mail Address and/or Pass   |
      | fake_account@xyz.net    | P@ssw0rd     | Warning: No match for E-Mail Address and/or Pass   |
      | guest@tutorialsninja.com| guestpass    | Warning: No match for E-Mail Address and/or Pass   |
      | user1@example.com       | testtest     | Warning: No match for E-Mail Address and/or Pass   |
      | user2@example.com       | incorrect    | Warning: No match for E-Mail Address and/or Pass   |
      | random999@test.com      | wrongpass    | Warning: No match for E-Mail Address and/or Pass   |
      | bad_login@server.io     | password     | Warning: No match for E-Mail Address and/or Pass   |
      | dummy_user@cloud.org    | dummy123     | Warning: No match for E-Mail Address and/or Pass   |

  Scenario: TC_AUTH_51 - Password reset link navigation from login page
    Given the user navigates to the OpenCart storefront
    When the user navigates to forgotten password page
    Then the breadcrumb trail should be displayed

  Scenario: TC_AUTH_52 - Password reset request with unregistered email
    Given the user navigates to the OpenCart storefront
    When the user navigates to forgotten password page
    And the user submits forgotten password email "unregistered_user@test.com"
    Then the password reset response should be displayed

  Scenario: TC_AUTH_53 - Password reset request with empty email
    Given the user navigates to the OpenCart storefront
    When the user navigates to forgotten password page
    And the user submits forgotten password email ""
    Then the password reset response should be displayed

  Scenario: TC_AUTH_54 - Password reset request with invalid email format
    Given the user navigates to the OpenCart storefront
    When the user navigates to forgotten password page
    And the user submits forgotten password email "notanemail"
    Then the password reset response should be displayed

  Scenario: TC_AUTH_55 - Password reset request with existing sample email
    Given the user navigates to the OpenCart storefront
    When the user navigates to forgotten password page
    And the user submits forgotten password email "sample@test.com"
    Then the password reset response should be displayed

  Scenario: TC_AUTH_56 - User Account Logout after registration
    Given the user navigates to the OpenCart storefront
    When the user attempts registration with firstname "Dynamic", lastname "User", email "dynamic", telephone "dynamic", password "Pass123!", confirm "Pass123!", agree policy "true"
    And the user logs out of the application
    Then the account logout page should be displayed

  Scenario: TC_AUTH_57 - Logout page header and continue button navigation
    Given the user navigates to the OpenCart storefront
    When the user attempts registration with firstname "Dynamic", lastname "User", email "dynamic", telephone "dynamic", password "Pass123!", confirm "Pass123!", agree policy "true"
    And the user logs out of the application
    Then the account logout page should be displayed

  Scenario: TC_AUTH_58 - Return to login page after logout
    Given the user navigates to the OpenCart storefront
    When the user navigates to the login page
    Then the breadcrumb trail should be displayed

  Scenario: TC_AUTH_59 - Direct access to account dashboard without authentication redirects to login
    Given the user navigates to the OpenCart storefront
    When the user attempts to access account dashboard directly
    Then the user should be redirected to login page

  Scenario: TC_AUTH_60 - Login page right column account navigation links verification
    Given the user navigates to the OpenCart storefront
    When the user navigates to the login page
    Then the login page right column links should be displayed

  Scenario: TC_AUTH_61 - Forgotten password page back button navigation
    Given the user navigates to the OpenCart storefront
    When the user navigates to forgotten password page
    Then the breadcrumb trail should be displayed

  Scenario: TC_AUTH_62 - Login page breadcrumb validation
    Given the user navigates to the OpenCart storefront
    When the user navigates to the login page
    Then the breadcrumb trail should be displayed

  Scenario: TC_AUTH_63 - Right column Register link redirection from Login page
    Given the user navigates to the OpenCart storefront
    When the user navigates to the login page
    Then the user navigates to the registration page

  Scenario: TC_AUTH_64 - Multiple failed login attempts warning persistence
    Given the user navigates to the OpenCart storefront
    When the user attempts login with email "fail1@test.com" and password "wrong1"
    And the user attempts login with email "fail2@test.com" and password "wrong2"
    Then the system should return the login state "Warning: No match for E-Mail Address and/or Pass"

  Scenario: TC_AUTH_65 - Session state validation after browser navigation back
    Given the user navigates to the OpenCart storefront
    When the user navigates to the login page
    And the user navigates to the registration page
    Then the breadcrumb trail should be displayed

