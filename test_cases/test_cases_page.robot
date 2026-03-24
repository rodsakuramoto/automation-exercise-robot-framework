*** Settings ***
Resource        ${EXECDIR}/steps/steps.resource


Suite Setup         Launch Browser
Suite Teardown      Close Browser

*** Test Cases ***
Verify Test Cases Page
    [Tags]    navigation    test_case    tc_007
    Given I am on the automation exercise homepage
    When I navigate to the Test Cases page
    Then I should see the test cases page