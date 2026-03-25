*** Settings ***
Resource    ${EXECDIR}/steps/steps.resource

*** Keywords ***
Create user account
    Open automation exercise homepage
    Open signup/login page
    Enter valid signup name and email
    Fill account information and address details
    Confirm account creation
    the account should be created successfully
    Verify user is logged in
    Capture Page Screenshot
    Click Element    ${account_created_deleted.logout_btn}

I register a new account successfully
    Open signup/login page
    Enter valid signup name and email
    Fill account information and address details
    Confirm account creation
    the account should be created successfully

I login with valid credentials
    Open signup/login page
    Enter correct email and password
    Click login button

# --- Authentication ---

I am logged in
    Create user account
    Open automation exercise homepage
    Open signup/login page
    Enter correct email and password
    Click login button
    Verify user is logged in

I am on the signup page
    Open automation exercise homepage
    Open signup/login page

I register a new user
    Open signup/login page
    Enter valid signup name and email
    Fill account information and address details
    Confirm account creation

I attempt to login with invalid credentials
    Open signup/login page
    Enter incorrect email and password
    Click login button

I attempt to register with an existing email
    Open signup/login page
    Enter existing signup name and email
    Click signup button
