*** Settings ***
Resource        ${EXECDIR}/helpers/cart_checkout_steps.resource


Suite Setup         Launch Browser
Suite Teardown      Close Browser

*** Test Cases ***
Add Products in Cart
    [Tags]    cart    products    regression    tc_012
    Given Open automation exercise homepage
    When I add two products to the cart
    Then both products should be added to the cart
    And their prices, quantity, and total price should be correct
    [Teardown]    Reset Browser State

Verify Product quantity in Cart
    [Tags]    cart    product_details    regression    tc_013
    Given I am on the product detail page of a product
    When I add "4" units of the product to the cart
    Then The product should be displayed in the cart with quantity "4"

Place Order: Register while Checkout
    [Tags]    checkout    e2e    regression    tc_014
    Given a product is in the cart
    When I checkout as a new user and place the order
    Then Verify order placed success message
    [Teardown]    Delete user account

Place Order: Register before Checkout
    [Tags]    checkout    e2e    regression    tc_015
    Given I am registered and logged in
    When I add a product to the cart and checkout to place the order
    Then Verify order placed success message
    [Teardown]    Delete user account

Place Order: Login before Checkout
    [Tags]    checkout    e2e    regression    tc_016
    Given I am logged in
    When I add a product to the cart and checkout to place the order
    Then Verify order placed success message
    [Teardown]    Delete user account

Remove Products From Cart
    [Tags]    cart    regression    tc_017
    Given a product is in the cart
    When Remove product from cart
    Then The product should be removed from the cart

Search Products and Verify Cart After Login
    [Tags]    search    cart    login    regression    tc_020
    [Setup]    Create user account
    Given I search for a product and add it to the cart
    When I login with valid credentials
    And Open Cart page
    Then Verify product is in cart
    [Teardown]    Delete user account

Verify address details in checkout page
    [Tags]    checkout    regression    tc_023
    Given I am a registered user with products in the cart
    When Proceed to checkout
    Then My address details should be pre-filled correctly
    [Teardown]    Delete user account

Download Invoice after purchase order
    [Tags]    invoice    checkout    regression    tc_024
    Given I have placed an order
    When Download invoice
    Then invoice is downloaded successfully
    And Click "Continue" button
    [Teardown]    Delete user account
