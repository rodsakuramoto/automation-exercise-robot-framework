*** Settings ***
Resource        ${EXECDIR}/steps/steps.resource


Suite Setup         Launch Browser
Suite Teardown      Close Browser

*** Test Cases ***
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