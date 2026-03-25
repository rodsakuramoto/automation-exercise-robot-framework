*** Settings ***
Resource    ${EXECDIR}/steps/steps.resource
Resource    ${EXECDIR}/helpers/authentication_steps.resource

*** Keywords ***

I add two products to the cart
    Open Products page
    Add first product to cart
    Continue shopping
    Add second product to cart
    Open cart from modal

I add "${quantity}" units of the product to the cart
    Set product quantity to "${quantity}"
    Add product to cart
    Open cart from modal

I am on the product detail page of a product
    Open automation exercise homepage
    Open first home page product details
    Verify product detail page is open

A product is in the cart
    Open automation exercise homepage
    Add products to cart
    Open Cart page

I am on the cart page
    Open automation exercise homepage
    Open Cart page

I search for a product and add it to the cart
    Open Products page
    Verify redirection to All Products page
    Search for product "Men Tshirt"
    Verify Searched Products section
    Verify products related to "Men Tshirt"
    Add searched products to cart
    Open Cart page
    Verify product is in cart

I add a recommended item to the cart
    Verify "RECOMMENDED ITEMS" section
    Add recommended product to cart
    Open cart from modal

# --- Checkout ---

I complete the payment process
    Enter comment and place order
    Enter payment details and confirm order
    Verify order placed success message

I checkout as a new user and place the order
    Proceed to checkout
    Start registration from checkout
    I register a new account successfully
    Verify user is logged in
    Open Cart page
    Proceed to checkout again
    Verify address details and review order
    Enter comment and place order
    Enter payment details and confirm order
    Verify order placed success message

I add a product to the cart and checkout to place the order
    Add products to cart
    Open Cart page
    Proceed to checkout
    Verify address details and review order
    Enter comment and place order
    Enter payment details and confirm order
    Verify order placed success message

I am registered and logged in
    Open automation exercise homepage
    I register a new account successfully
    Verify user is logged in

I am a registered user with products in the cart
    Open automation exercise homepage
    I register a new account successfully
    Verify user is logged in
    Add products to cart
    Open Cart page
    Verify product is in cart

I have placed an order
    Open automation exercise homepage
    Add products to cart
    Open Cart page
    Proceed to checkout
    Start registration from checkout
    I register a new account successfully
    Verify user is logged in
    Open Cart page
    Proceed to checkout again
    Verify address details and review order
    Enter comment and place order
    Enter payment details and confirm order
    Verify order placed success message
    Capture Page Screenshot

My address details should be pre-filled correctly
    Verify address details and review order
    Verify delivery and billing address match registration address
