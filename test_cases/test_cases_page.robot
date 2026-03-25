*** Settings ***
Resource        ${EXECDIR}/steps/steps.resource


Suite Setup         Launch Browser
Suite Teardown      Close Browser

*** Test Cases ***
Verify Test Cases Page
    [Tags]    navigation    test_case    tc_007
    Given Open automation exercise homepage
    When Open Test Cases section
    Then the test cases catalog should be accessible
