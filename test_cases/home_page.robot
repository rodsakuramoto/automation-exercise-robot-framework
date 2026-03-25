*** Settings ***
Resource        ${EXECDIR}/helpers/home_page_steps.resource
Resource        ${EXECDIR}/helpers/cart_checkout_steps.resource


Suite Setup         Launch Browser
Suite Teardown      Close Browser

*** Test Cases ***
Add to cart from Recommended items
    [Tags]    cart    home    regression    tc_022
    Given Open automation exercise homepage
    When I add a recommended item to the cart
    Then The recommended product should be displayed in the cart

Verify Scroll Up using 'Arrow' button and Scroll Down functionality
    [Tags]    scroll    home    regression    tc_025
    Given Open automation exercise homepage
    When I scroll to the bottom and then to the top using the arrow
    Then the page should be scrolled to the top

Verify Scroll Up without 'Arrow' button and Scroll Down functionality
    [Tags]    scroll    home    regression    tc_026
    Given Open automation exercise homepage
    When I scroll to the bottom and then back to the top
    Then the page should be scrolled to the top
