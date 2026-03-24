*** Settings ***
Resource        ${EXECDIR}/steps/steps.resource


Suite Setup         Launch Browser
Suite Teardown      Close Browser

*** Test Cases ***
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

Add review on product
    [Tags]    products    review    regression    tc_021
    Given I am on the automation exercise homepage
    When I navigate to the Products page
    Then I should be redirected to the All Products page
    When I click on View Product of the first product
    Then I should see the "Write Your Review" section
    When I submit a review with name, email, and content
    Then I should see the review success message