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
    When I search for the product "Men Tshirt"
    Then products matching "Men Tshirt" should be displayed

View Category Products
    [Tags]    category    navigation    regression    tc_018
    Given I am on the automation exercise homepage
    Then the category sidebar should be visible
    When I navigate to the "Women" > "Dress" category
    Then I should see the "Women - Dress Products" catalog
    When I navigate to the "Men" > "Tshirts" category
    Then I should see the "Men - Tshirts Products" catalog

View Brand Products
    [Tags]    brand    navigation    regression    tc_019
    Given I am on the all products page
    Then the brands sidebar should be visible
    When I filter by brand "Polo"
    Then I should see the "Brand - Polo Products" catalog
    When I filter by brand "H&M"
    Then I should see the "Brand - H&M Products" catalog

Add review on product
    [Tags]    products    review    regression    tc_021
    Given I am viewing a product's details
    When I submit a review
    Then I should see a success message for the review