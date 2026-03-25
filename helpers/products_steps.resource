*** Settings ***
Resource    ${EXECDIR}/steps/steps.resource

*** Keywords ***

I am on the all products page
    Open automation exercise homepage
    Open Products page
    Verify redirection to All Products page

I am viewing a product's details
    Open automation exercise homepage
    Open Products page
    Verify redirection to All Products page
    Open first product details
    Verify product detail page is open

I view a product's details
    Open first product details

I should see the correct product details
    Verify product detail page is open
    Verify product details are visible

products matching "${term}" should be displayed
    Verify Searched Products section
    Verify products related to "${term}"

I submit a review
    Verify "Write Your Review" section
    Submit valid product review
