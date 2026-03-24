*** Settings ***
Resource        ${EXECDIR}/steps/steps.resource


Suite Setup         Launch Browser
Suite Teardown      Close Browser

*** Test Cases ***
Register a new user successfully
    [Tags]    smoke    registration    tc_001
    Given I am on the automation exercise homepage
    When I start the new user login/signup process
    And I enter valid name and email address
    And I fill in the account information and address details
    And I confirm the account creation
    Then the account should be created successfully
    And I should see that I am logged in
    [Teardown]    Delete user account

Login User with correct email and password
    [Tags]    smoke    login    tc_002
    [Setup]    Create user account
    Given I am on the automation exercise homepage
    When I login with valid credentials
    [Teardown]    Delete user account

Login User with incorrect email and password
    [Tags]    smoke    login    tc_003
    Given I am on the automation exercise homepage
    When I start the new user login/signup process
    And I enter incorrect email and password
    And I click login button
    Then I should see a error message of incorrect email or password

Logout User
    [Tags]    smoke    logout    tc_004
    [Setup]    Create user account
    Given I am on the automation exercise homepage
    When I login with valid credentials
    And I click logout button
    Then I should be redirected to the login page

Register User with existing email
    [Tags]    smoke    registration    tc_005
    [Setup]    Create user account
    Given I am on the automation exercise homepage
    When I start the new user login/signup process
    And I enter an existing name and email address
    And I click signup button
    Then I should see a error message that email address already exist