*** Settings ***
Resource        ${EXECDIR}/steps/steps.resource


Suite Setup         Launch Browser
Suite Teardown      Close Browser

*** Test Cases ***
Register a new user successfully
    [Tags]    smoke    registration    tc_001
    Given I am on the automation exercise homepage
    When I register a new user
    Then I should be successfully registered and logged in
    [Teardown]    Delete user account

Login User with correct email and password
    [Tags]    smoke    login    tc_002
    [Setup]    Create user account
    Given I am on the automation exercise homepage
    When I login with valid credentials
    Then I should be logged in
    [Teardown]    Delete user account

Login User with incorrect email and password
    [Tags]    smoke    login    tc_003
    Given I am on the automation exercise homepage
    When I attempt to login with invalid credentials
    Then I should see an invalid credentials error message

Logout User
    [Tags]    smoke    logout    tc_004
    Given I am logged in
    When I log out
    Then I should be redirected to the login page

Register User with existing email
    [Tags]    smoke    registration    tc_005
    [Setup]    Create user account
    Given I am on the signup page
    When I attempt to register with an existing email
    Then I should see an email exists error message