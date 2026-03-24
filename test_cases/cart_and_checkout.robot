*** Settings ***
Resource        ${EXECDIR}/steps/steps.resource


Suite Setup         Launch Browser
Suite Teardown      Close Browser

*** Test Cases ***
Add Products in Cart
    [Tags]    cart    products    regression    tc_012
    Given I am on the automation exercise homepage
    When I navigate to the Products page
    And I add the first product to the cart
    And I continue shopping
    And I add the second product to the cart
    And I view the cart
    Then both products should be added to the cart
    And their prices, quantity, and total price should be correct
    [Teardown]    Reset Browser State

Verify Product quantity in Cart
    [Tags]    cart    product_details    regression    tc_013
    Given I am on the automation exercise homepage
    When I click on View Product for the first product
    Then I should be landed on the product detail page
    When I increase the quantity to "4"
    And I add the product to the cart
    And I view the cart
    Then the product should be displayed in the cart with quantity "4"

Place Order: Register while Checkout
    [Tags]    checkout    e2e    regression    tc_014
    Given I am on the automation exercise homepage
    When I add products to the cart
    And I navigate to the Cart page
    And I proceed to checkout
    And I choose to register or login from the checkout modal
    And I register a new account successfully
    And I should see that I am logged in
    And I navigate to the Cart page
    And I proceed to checkout again
    Then I should see the address details and review order
    When I complete the payment process
    [Teardown]    Delete user account

Place Order: Register before Checkout
    [Tags]    checkout    e2e    regression    tc_015
    Given I am on the automation exercise homepage
    When I register a new account successfully
    And I should see that I am logged in
    And I add products to the cart
    And I navigate to the Cart page
    And I proceed to checkout
    Then I should see the address details and review order
    When I complete the payment process
    [Teardown]    Delete user account

Place Order: Login before Checkout
    [Tags]    checkout    e2e    regression    tc_016
    [Setup]    Create user account
    Given I am on the automation exercise homepage
    When I login with valid credentials
    And I add products to the cart
    And I navigate to the Cart page
    And I proceed to checkout
    Then I should see the address details and review order
    When I complete the payment process
    [Teardown]    Delete user account

Remove Products From Cart
    [Tags]    cart    regression    tc_017
    Given I am on the automation exercise homepage
    When I add products to the cart
    And I navigate to the Cart page
    Then I should see the product in the cart
    When I remove the product from the cart
    Then the product should be removed from the cart

Search Products and Verify Cart After Login
    [Tags]    search    cart    login    regression    tc_020
    [Setup]    Create user account
    Given I am on the automation exercise homepage
    When I navigate to the Products page
    Then I should be redirected to the All Products page
    When I search for the product "Men Tshirt"
    Then I should see the Searched Products section
    And I should see products related to "Men Tshirt"
    When I add the searched products to the cart
    And I navigate to the Cart page
    Then I should see the product in the cart
    When I start the new user login/signup process
    And I enter correct email and password
    And I click login button
    And I navigate to the Cart page
    Then I should see the product in the cart
    [Teardown]    Delete user account

Verify address details in checkout page
    [Tags]    checkout    regression    tc_023
    Given I am on the automation exercise homepage
    When I start the new user login/signup process
    And I enter valid name and email address
    And I fill in the account information and address details
    And I confirm the account creation
    Then the account should be created successfully
    And I should see that I am logged in
    When I add products to the cart
    And I navigate to the Cart page
    Then I should see the product in the cart
    When I proceed to checkout
    Then I should see the address details and review order
    And I verify that the delivery and billing address is the same as the registration address
    [Teardown]    Delete user account

Download Invoice after purchase order
    [Tags]    invoice    checkout    regression    tc_024
    Given I am on the automation exercise homepage
    When I place an order as a newly registered user
    When I download the invoice
    Then invoice is downloaded successfully
    And I click the "Continue" button
    [Teardown]    Delete user account