*** Settings ***
Resource        ${EXECDIR}/steps/steps.resource


Suite Setup         Launch Browser
Suite Teardown      Close Browser

*** Test Cases ***
Contact Us Form
    [Tags]    contact    regression    tc_006
    Given I am on the automation exercise homepage
    When I submit the contact us form with valid details
    Then I should see a success message and be able to return home