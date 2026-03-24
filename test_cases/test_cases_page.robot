*** Settings ***
Resource        ${EXECDIR}/steps/steps.resource


Suite Setup         Launch Browser
Suite Teardown      Close Browser

*** Test Cases ***
Verify Test Cases Page
    [Tags]    navigation    test_case    tc_007
    Given I am on the automation exercise homepage
    When I navigate to the Test Cases section
    Then the test cases catalog should be accessible