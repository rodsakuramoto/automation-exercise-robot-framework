*** Settings ***
Resource        ${EXECDIR}/helpers/subscription_steps.resource
Resource        ${EXECDIR}/helpers/cart_checkout_steps.resource


Suite Setup         Launch Browser
Suite Teardown      Close Browser

*** Test Cases ***
Verify Subscription in home page
    [Tags]    subscription    smoke    tc_010
    Given Open automation exercise homepage
    When I subscribe to the newsletter
    Then Verify subscription success message

Verify Subscription in Cart page
    [Tags]    subscription    cart    smoke    tc_011
    Given I am on the cart page
    When I subscribe to the newsletter
    Then Verify subscription success message
