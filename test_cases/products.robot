*** Settings ***
Resource        ${EXECDIR}/steps/steps.resource


Suite Setup         Launch Browser
Suite Teardown      Close Browser

*** Test Cases ***
Verify All Products and product detail page
    [Tags]    products    smoke    tc_008
    Given I am on the all products page
    When I view a product's details
    Then I should see the correct product details

Search Product
    [Tags]    search    products    regression    tc_009
    Given I am on the all products page
    When Search for product "Men Tshirt"
    Then products matching "Men Tshirt" should be displayed

View Category Products
    [Tags]    category    navigation    regression    tc_018
    Given Open automation exercise homepage
    Then the category sidebar should be visible
    When Open "Women" > "Dress" category
    Then The "Women - Dress Products" catalog should be displayed
    When Open "Men" > "Tshirts" category
    Then The "Men - Tshirts Products" catalog should be displayed

View Brand Products
    [Tags]    brand    navigation    regression    tc_019
    Given I am on the all products page
    Then the brands sidebar should be visible
    When Filter products by brand "Polo"
    Then The "Brand - Polo Products" catalog should be displayed
    When Filter products by brand "H&M"
    Then The "Brand - H&M Products" catalog should be displayed

Add review on product
    [Tags]    products    review    regression    tc_021
    Given I am viewing a product's details
    When I submit a review
    Then Verify review success message
