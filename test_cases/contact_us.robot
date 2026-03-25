*** Settings ***
Resource        ${EXECDIR}/steps/steps.resource

Suite Setup         Launch Browser
Suite Teardown      Close Browser

*** Test Cases ***
Contact Us Form
    [Tags]    contact    regression    tc_006
    Given Open automation exercise homepage
    When Open Contact Us page
    And Submit contact form with valid details and file
    Then Verify contact form success message
    And Return to home page
