*** Settings ***
Resource        ${EXECDIR}/steps/steps.resource


Suite Setup         Launch Browser
Suite Teardown      Close Browser

*** Test Cases ***
Contact Us Form
    [Tags]    contact    regression    tc_006
    Given I am on the automation exercise homepage
    When I navigate to the Contact Us page
    And I submit the contact form with valid details and a file
    Then I should see the success message
    And I should be able to return to the home page