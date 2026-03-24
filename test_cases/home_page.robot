*** Settings ***
Resource        ${EXECDIR}/steps/steps.resource


Suite Setup         Launch Browser
Suite Teardown      Close Browser

*** Test Cases ***
Add to cart from Recommended items
    [Tags]    cart    home    regression    tc_022
    Given I am on the automation exercise homepage
    When I should see the "RECOMMENDED ITEMS" section
    And I add a recommended product to the cart
    And I view the cart
    Then The recommended product should be displayed in the cart

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