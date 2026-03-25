*** Settings ***
Resource    ${EXECDIR}/steps/steps.resource

*** Keywords ***

I scroll to the bottom and then to the top using the arrow
    Scroll to bottom of page
    the "SUBSCRIPTION" section should be visible
    Scroll up using arrow button

I scroll to the bottom and then back to the top
    Scroll to bottom of page
    the "SUBSCRIPTION" section should be visible
    Scroll to top of page
