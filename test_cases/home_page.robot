*** Settings ***
Resource        ${EXECDIR}/steps/steps.resource


Suite Setup         Launch Browser
Suite Teardown      Close Browser

*** Test Cases ***
Add to cart from Recommended items
    [Tags]    cart    home    regression    tc_022
    Given I am on the automation exercise homepage
    When I add a recommended item to the cart
    Then the item should appear in the cart

Verify Scroll Up using 'Arrow' button and Scroll Down functionality
    [Tags]    scroll    home    regression    tc_025
    Given I am on the automation exercise homepage
    When I scroll to the bottom and then to the top using the arrow
    Then the page should scroll accordingly

Verify Scroll Up without 'Arrow' button and Scroll Down functionality
    [Tags]    scroll    home    regression    tc_026
    Given I am on the automation exercise homepage
    When I scroll to the bottom and then back to the top
    Then the page should scroll accordingly