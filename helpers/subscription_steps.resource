*** Settings ***
Resource    ${EXECDIR}/steps/steps.resource

*** Keywords ***
I subscribe to the newsletter
    Scroll down to footer
    ${random_email}    FakerLibrary.Email
    Input Text         ${footer.email_input}    ${random_email}
    Click Button       ${footer.submit_btn}
