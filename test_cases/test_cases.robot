*** Settings ***
Resource        ${EXECDIR}/steps/steps.resource


Suite Setup         Launch Browser
Suite Teardown      Close Browser

*** Test Cases ***
Register a new user successfully
    [Tags]    smoke    registration    tc_001
    Given I am on the automation exercise homepage
    When I start the new user login/signup process
    And I enter valid name and email address
    And I fill in the account information and address details
    And I confirm the account creation
    Then the account should be created successfully
    And I should see that I am logged in
    [Teardown]    Delete user account

Login User with correct email and password
    [Tags]    smoke    login    tc_002
    [Setup]    Create user account
    Given I am on the automation exercise homepage
    When I start the new user login/signup process
    And I enter correct email and password
    And I click login button
    Then I should see that I am logged in
    [Teardown]    Delete user account

Login User with incorrect email and password
    [Tags]    smoke    login    tc_003
    Given I am on the automation exercise homepage
    When I start the new user login/signup process
    And I enter incorrect email and password
    And I click login button
    Then I should see a error message of incorrect email or password

Logout User
    [Tags]    smoke    logout    tc_004
    [Setup]    Create user account
    Given I am on the automation exercise homepage
    When I start the new user login/signup process
    And I enter correct email and password
    And I click login button
    And I should see that I am logged in
    And I click logout button
    Then I should be redirected to the login page

Register User with existing email
    [Tags]    smoke    registration    tc_005
    [Setup]    Create user account
    Given I am on the automation exercise homepage
    When I start the new user login/signup process
    And I enter an existing name and email address
    And I click signup button
    Then I should see a error message that email address already exist

Contact Us Form
    [Tags]    contact    regression    tc_006
    Given I am on the automation exercise homepage
    When I navigate to the Contact Us page
    And I submit the contact form with valid details and a file
    Then I should see the success message
    And I should be able to return to the home page

Verify Test Cases Page
    [Tags]    navigation    test_case    tc_007
    Given I am on the automation exercise homepage
    When I navigate to the Test Cases section
    Then the test cases catalog should be accessible

Verify All Products and product detail page
    [Tags]    products    smoke    tc_008
    Given I am on the automation exercise homepage
    When I navigate to the Products page
    Then I should be redirected to the All Products page
    And The products list should be visible
    When I click on View Product of the first product
    Then I should be landed on the product detail page
    And I should see the product details including name, category, price, availability, condition, and brand

Search Product
    [Tags]    search    products    regression    tc_009
    Given I am on the automation exercise homepage
    When I navigate to the Products page
    Then I should be redirected to the All Products page
    When I search for the product "Men Tshirt"
    Then I should see the Searched Products section
    And I should see products related to "Men Tshirt"

Verify Subscription in home page
    [Tags]    subscription    smoke    tc_010
    Given I am on the automation exercise homepage
    When I scroll down to the footer
    And I enter email address in subscription input and click arrow button
    Then I should see the subscription success message

Verify Subscription in Cart page
    [Tags]    subscription    cart    smoke    tc_011
    Given I am on the automation exercise homepage
    When I navigate to the Cart page
    And I scroll down to the footer
    And I enter email address in subscription input and click arrow button
    Then I should see the subscription success message

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
    When I enter a comment and place the order
    And I enter payment details and confirm the order
    Then I should see the order placed success message
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
    When I enter a comment and place the order
    And I enter payment details and confirm the order
    Then I should see the order placed success message
    [Teardown]    Delete user account

Place Order: Login before Checkout
    [Tags]    checkout    e2e    regression    tc_016
    [Setup]    Create user account
    Given I am on the automation exercise homepage
    When I start the new user login/signup process
    And I enter correct email and password
    And I click login button
    And I should see that I am logged in
    And I add products to the cart
    And I navigate to the Cart page
    And I proceed to checkout
    Then I should see the address details and review order
    When I enter a comment and place the order
    And I enter payment details and confirm the order
    Then I should see the order placed success message
    [Teardown]    Delete user account

Remove Products From Cart
    [Tags]    cart    regression    tc_017
    Given I am on the automation exercise homepage
    When I add products to the cart
    And I navigate to the Cart page
    Then I should see the product in the cart
    When I remove the product from the cart
    Then the product should be removed from the cart

View Category Products
    [Tags]    category    navigation    regression    tc_018
    Given I am on the automation exercise homepage
    Then the category sidebar should be visible
    When I browse to the "Women" > "Dress" category
    Then the "Women - Dress Products" catalog should be displayed
    When I browse to the "Men" > "Tshirts" category
    Then the "Men - Tshirts Products" catalog should be displayed

View Brand Products
    [Tags]    brand    navigation    regression    tc_019
    Given I am on the automation exercise homepage
    And I navigate to the Products page
    Then the brands sidebar should be visible
    When I filter products by the brand "Polo"
    Then the "Brand - Polo Products" catalog should be displayed
    When I filter products by the brand "H&M"
    Then the "Brand - H&M Products" catalog should be displayed

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

Add review on product
    [Tags]    products    review    regression    tc_021
    Given I am on the automation exercise homepage
    When I navigate to the Products page
    Then I should be redirected to the All Products page
    When I click on View Product of the first product
    Then I should see the "Write Your Review" section
    When I submit a review with name, email, and content
    Then I should see the review success message

Add to cart from Recommended items
    [Tags]    cart    home    regression    tc_022
    Given I am on the automation exercise homepage
    When I scroll to the bottom of the page
    Then I should see the "RECOMMENDED ITEMS" section
    When I add a recommended product to the cart
    And I view the cart
    Then The recommended product should be displayed in the cart

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
    When I add products to the cart
    And I navigate to the Cart page
    And I proceed to checkout
    And I choose to register or login from the checkout modal
    And I register a new account successfully
    And I should see that I am logged in
    And I navigate to the Cart page
    And I proceed to checkout again
    Then I should see the address details and review order
    When I enter a comment and place the order
    And I enter payment details and confirm the order
    Then I should see the order placed success message
    When I download the invoice
    Then invoice is downloaded successfully
    And I click the "Continue" button
    [Teardown]    Delete user account

Verify Scroll Up using 'Arrow' button and Scroll Down functionality
    [Tags]    scroll    home    regression    tc_025
    Given I am on the automation exercise homepage
    When I scroll to the bottom of the page
    Then I verify "SUBSCRIPTION" is visible
    When I click on the scroll up arrow
    Then I verify that the page is scrolled up and the full-fledged text is visible

Verify Scroll Up without 'Arrow' button and Scroll Down functionality
    [Tags]    scroll    home    regression    tc_026
    Given I am on the automation exercise homepage
    When I scroll to the bottom of the page
    Then I verify "SUBSCRIPTION" is visible
    When I scroll up to the top of the page
    Then I verify that the page is scrolled up and the full-fledged text is visible