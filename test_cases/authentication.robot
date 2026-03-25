*** Settings ***
Resource        ${EXECDIR}/helpers/authentication_steps.resource


Suite Setup         Launch Browser
Suite Teardown      Close Browser

*** Test Cases ***
Register a new user successfully
    [Tags]    smoke    registration    tc_001
    Given Open automation exercise homepage
    When I register a new user
    Then the account should be created successfully
    And Verify user is logged in
    [Teardown]    Delete user account

Login User with correct email and password
    [Tags]    smoke    login    tc_002
    [Setup]    Create user account
    Given Open automation exercise homepage
    When I login with valid credentials
    Then Verify user is logged in
    [Teardown]    Delete user account

Login User with incorrect email and password
    [Tags]    smoke    login    tc_003
    Given Open automation exercise homepage
    When I attempt to login with invalid credentials
    Then Verify incorrect email or password error message

Logout User
    [Tags]    smoke    logout    tc_004
    Given I am logged in
    When Logout from account
    Then Verify redirection to login page

Register User with existing email
    [Tags]    smoke    registration    tc_005
    [Setup]    Create user account
    Given I am on the signup page
    When I attempt to register with an existing email
    Then Verify existing email error message
