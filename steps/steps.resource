*** Settings ***
Resource    ${EXECDIR}/resource/resource.resource
Resource    ${EXECDIR}/elements/elements.resource


*** Variables ***
${BROWSER}    chrome
${URL}     http://automationexercise.com
${USER_NAME}
${FIRST_NAME}
${LAST_NAME}
${USER_EMAIL}
${USER_PASSWORD}
${COMPANY}
${ADDRESS1}
${ADDRESS2}
${STATE}
${CITY}
${ZIPCODE}
${MOBILE_NUMBER}


# ==============================================================================
# SECTION 1 — IMPERATIVE STEPS (direct Selenium/library calls only)
# ==============================================================================

*** Keywords ***
Launch browser
    ${prefs}=    Create Dictionary    download.default_directory=${EXECDIR}    download.prompt_for_download=${FALSE}
    Open Browser    browser=chrome    options=add_experimental_option("prefs", ${prefs});add_argument("--disable-notifications");add_argument("--disable-popup-blocking");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--headless");add_argument("--host-resolver-rules=MAP *googleadservices.com 0.0.0.0, MAP *googlesyndication.com 0.0.0.0, MAP *g.doubleclick.net 0.0.0.0")
    Set Window Size    1920    1080

Open automation exercise homepage
    Go To  url=${URL}
    Title Should Be    Automation Exercise
    Wait Until Element Is Visible    ${home_page.home_logo}
    # Performance: Only wait for the main element. Check existence of others without explicit waits.
    Page Should Contain Element    ${home_page.signup_login_btn}

Open signup/login page
    Click Element    ${home_page.signup_login_btn}
    Wait Until Element Is Visible    ${login_signup_page.signup_header}
    Wait Until Element Is Visible    ${login_signup_page.signup_name_input}
    Wait Until Element Is Visible    ${login_signup_page.signup_email_input}
    Wait Until Element Is Visible    ${login_signup_page.login_header}
    Wait Until Element Is Visible    ${login_signup_page.login_email_input}
    Wait Until Element Is Visible    ${login_signup_page.login_password_input}
    Wait Until Element Is Visible    ${login_signup_page.login_btn}

Enter valid signup name and email
    ${user_name}    FakerLibrary.Name
    FOR    ${index}    IN RANGE    5
        ${user_email}    FakerLibrary.Email
        Input Text    ${login_signup_page.signup_name_input}    ${user_name}
        Input Text    ${login_signup_page.signup_email_input}    ${user_email}
        Click Element    ${login_signup_page.signup_btn}
        ${is_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${account_info_page.account_info_text}
        Exit For Loop If    ${is_visible}
    END
    Run Keyword If    not ${is_visible}    Fail    Failed to proceed to the account info page after 5 attempts.
    Capture Page Screenshot

    Set Test Variable    ${USER_NAME}    ${user_name}
    Set Test Variable    ${USER_EMAIL}   ${user_email}

    @{user_name_parts}    Split String
    ...    string=${user_name}
    ...    separator=${SPACE}

    Set Test Variable    ${FIRST_NAME}    ${user_name_parts}[0]
    ${parts_length}=     Get Length       ${user_name_parts}
    ${last_name_val}=    Run Keyword If   ${parts_length} > 1    Set Variable    ${user_name_parts}[1]    ELSE    Set Variable    ${user_name_parts}[0]
    Set Test Variable    ${LAST_NAME}     ${last_name_val}

Fill account information and address details
    Click Element    ${account_info_page.gender_male_radio}
    Capture Page Screenshot
    ${user_password}    FakerLibrary.Password  special_chars=false
    Input Text    ${account_info_page.password_input}    ${user_password}
    Select From List By Value    ${account_info_page.day_select}    1
    Select From List By Value    ${account_info_page.month_select}    1
    Select From List By Value    ${account_info_page.year_select}    2000
    Select Checkbox    ${account_info_page.newsletter_checkbox}
    Select Checkbox    ${account_info_page.optin_checkbox}
    ${company}       FakerLibrary.Company
    ${address1}      FakerLibrary.StreetAddress
    ${address2}      FakerLibrary.SecondaryAddress    # robotcode: ignore
    ${state}         FakerLibrary.State
    ${city}          FakerLibrary.City
    ${zipcode}       FakerLibrary.ZipCode     # robotcode: ignore
    ${mobile_number}    FakerLibrary.PhoneNumber

    Input Text    ${account_info_page.first_name_input}    ${FIRST_NAME}
    Input Text    ${account_info_page.last_name_input}     ${LAST_NAME}
    Input Text    ${account_info_page.company_input}       ${company}
    Input Text    ${account_info_page.address1_input}      ${address1}
    Input Text    ${account_info_page.address2_input}      ${address2}
    Select From List By Value    ${account_info_page.country_select}    United States
    Input Text    ${account_info_page.state_input}         ${state}
    Input Text    ${account_info_page.city_input}         ${city}
    Input Text    ${account_info_page.zipcode_input}       ${zipcode}
    Input Text    ${account_info_page.mobile_number_input}     ${mobile_number}

    Set Test Variable    ${USER_PASSWORD}    ${user_password}
    Set Test Variable    ${COMPANY}    ${company}
    Set Test Variable    ${ADDRESS1}    ${address1}
    Set Test Variable    ${ADDRESS2}    ${address2}
    Set Test Variable    ${STATE}    ${state}
    Set Test Variable    ${CITY}    ${city}
    Set Test Variable    ${ZIPCODE}    ${zipcode}
    Set Test Variable    ${MOBILE_NUMBER}    ${mobile_number}

Confirm account creation
    Click Element    ${account_info_page.create_account_btn}
    Capture Page Screenshot

the account should be created successfully
    Wait Until Element Is Visible    ${account_created_deleted.account_created_msg}
    Click Element    ${account_created_deleted.continue_btn}

Verify user is logged in
    Wait Until Element Is Enabled    ${account_created_deleted.logout_btn}
    Wait Until Element Is Visible    ${account_created_deleted.delete_account_btn}

    ${logged_in_as_text}    Replace String
    ...       string=${account_created_deleted.logged_in_as_text}
    ...       search_for=user_name
    ...       replace_with=${USER_NAME}

    Wait Until Element Is Visible  ${logged_in_as_text}
    Capture Page Screenshot

Delete user account
    Click Element    ${account_created_deleted.delete_account_btn}
    Wait Until Element Is Visible    ${account_created_deleted.account_deleted_msg}
    Click Element    ${account_created_deleted.continue_btn}

Enter correct email and password
    Input Text    ${login_signup_page.login_email_input}    ${USER_EMAIL}
    Input Text    ${login_signup_page.login_password_input}    ${USER_PASSWORD}

Click login button
    Click Element    ${login_signup_page.login_btn}

Enter incorrect email and password
    Input Text    ${login_signup_page.login_email_input}    incorrect_email@example.com
    Input Text    ${login_signup_page.login_password_input}    wrong_password

Verify incorrect email or password error message
    Wait Until Element Is Visible    ${login_signup_page.login_error_msg}
    Element Text Should Be    ${login_signup_page.login_error_msg}    Your email or password is incorrect!

Logout from account
    Click Element    ${account_created_deleted.logout_btn}

Verify redirection to login page
    Wait Until Element Is Visible    ${login_signup_page.login_header}
    Wait Until Element Is Visible    ${login_signup_page.signup_header}
    Wait Until Element Is Visible    ${login_signup_page.signup_name_input}
    Wait Until Element Is Visible    ${login_signup_page.signup_email_input}
    Wait Until Element Is Visible    ${login_signup_page.login_header}
    Wait Until Element Is Visible    ${login_signup_page.login_email_input}
    Wait Until Element Is Visible    ${login_signup_page.login_password_input}
    Wait Until Element Is Visible    ${login_signup_page.login_btn}

Enter existing signup name and email
    Input Text    ${login_signup_page.signup_name_input}    ${USER_NAME}
    Input Text    ${login_signup_page.signup_email_input}    ${USER_EMAIL}

Click signup button
    Click Element    ${login_signup_page.signup_btn}

Verify existing email error message
    Wait Until Element Is Visible   ${login_signup_page.signup_error_msg}

Open Contact Us page
    Click Element    ${HOME_PAGE.contact_us_link}
    Page Should Contain    Get In Touch
    Wait Until Element Is Visible    ${contact_us_page.header}
    Element Should Be Visible        ${contact_us_page.name_input}
    Element Should Be Visible        ${contact_us_page.email_input}
    Element Should Be Visible        ${contact_us_page.subject_input}
    Element Should Be Visible        ${contact_us_page.message_textarea}
    Element Should Be Visible        ${contact_us_page.upload_file_input}
    Element Should Be Visible        ${contact_us_page.submit_button}

Submit contact form with valid details and file
    ${user_name}    FakerLibrary.Name
    ${user_email}    FakerLibrary.Email
    ${contact_subject}    FakerLibrary.Words
    ${contact_message}    FakerLibrary.Paragraphs

    Input Text    ${contact_us_page.name_input}       ${user_name}
    Input Text    ${contact_us_page.email_input}      ${user_email}
    Input Text    ${contact_us_page.subject_input}    ${contact_subject}
    Input Text    ${contact_us_page.message_textarea}    ${contact_message}

    ${file_path}      Set Variable    ${EXECDIR}/steps/utils/testfile.txt

    # Ensure file exists before trying to upload to avoid confusing errors
    ${file_exists}=    Run Keyword And Return Status    File Should Exist    ${file_path}
    Run Keyword If    not ${file_exists}    Create File    ${file_path}    content=This is a dummy file for automation testing.

    Choose File   ${contact_us_page.upload_file_input}     ${file_path}
    Click Button  ${contact_us_page.submit_button}
    Handle Alert  ACCEPT

Verify contact form success message
    Wait Until Element Is Visible    ${contact_us_page.success_msg}
    Page Should Contain    Success! Your details have been submitted successfully.

Return to home page
    Click Element    ${home_page.home_link}
    Title Should Be    Automation Exercise
    Wait Until Element Is Visible    ${home_page.home_logo}
    Wait Until Element Is Visible    ${home_page.home_link}

Open Test Cases section
    Click Element    ${home_page.test_cases_link}

the test cases catalog should be accessible
    Title Should Be    Automation Practice Website for UI Testing - Test Cases
    Wait Until Element Is Visible    ${test_cases_page.list_container}
    Element Should Be Visible        ${test_cases_page.header}

Open Products page
    Click Element    ${home_page.products_link}

Verify redirection to All Products page
    Title Should Be    Automation Exercise - All Products
    Wait Until Element Is Visible    ${products_page.header}
    Element Should Contain    ${products_page.header}    ALL PRODUCTS

The products list should be visible
    Wait Until Element Is Visible    ${products_page.products_list}

Open first product details
    Wait Until Element Is Visible    ${products_page.first_product_view_btn}
    Click Element    ${products_page.first_product_view_btn}

Verify product detail page is open
    Title Should Be    Automation Exercise - Product Details
    Wait Until Element Is Visible    ${product_details_page.product_name}

Verify product details are visible
    Element Should Be Visible    ${product_details_page.product_name}
    Element Should Be Visible    ${product_details_page.category}
    Element Should Be Visible    ${product_details_page.price}
    Element Should Be Visible    ${product_details_page.availability}
    Element Should Be Visible    ${product_details_page.condition}
    Element Should Be Visible    ${product_details_page.brand}

Search for product "${product_name}"
    Wait Until Element Is Visible    ${products_page.search_input}
    Input Text       ${products_page.search_input}    ${product_name}
    Click Button     ${products_page.search_btn}

Verify Searched Products section
    Wait Until Element Is Visible    ${products_page.searched_products_header}
    Element Should Contain           ${products_page.searched_products_header}    SEARCHED PRODUCTS

Verify products related to "${search_term}"
    Wait Until Element Is Visible    ${products_page.products_list}
    Page Should Contain Element      ${products_page.product_names}
    Page Should Contain              ${search_term}

Scroll down to footer
    Scroll Element Into View         ${footer.subscription_header}
    Wait Until Element Is Visible    ${footer.subscription_header}
    Element Should Contain           ${footer.subscription_header}    SUBSCRIPTION

Verify subscription success message
    Wait Until Element Is Visible    ${footer.success_msg}
    Element Should Contain           ${footer.success_msg}    You have been successfully subscribed!

Open Cart page
    Wait Until Element Is Enabled    ${home_page.cart_link}    timeout=5s
    Click Element                    ${home_page.cart_link}
    Title Should Be    Automation Exercise - Checkout
    Wait Until Element Is Visible    ${cart_page.breadcrumb}

Add first product to cart
    Wait Until Element Is Visible    ${products_page.add_to_cart_1}
    Click Element                    ${products_page.add_to_cart_1}

Continue shopping
    Wait Until Element Is Visible    ${products_page.continue_shopping_btn}
    Click Element                    ${products_page.continue_shopping_btn}

Add second product to cart
    Wait Until Element Is Visible    ${products_page.add_to_cart_2}
    Click Element                    ${products_page.add_to_cart_2}

Open cart from modal
    Wait Until Element Is Visible    ${products_page.view_cart_modal_link}
    Click Element                    ${products_page.view_cart_modal_link}

both products should be added to the cart
    Title Should Be    Automation Exercise - Checkout
    Wait Until Element Is Visible    ${cart_page.cart_rows}
    ${count}=    Get Element Count   ${cart_page.cart_rows}
    Should Be Equal As Integers      ${count}    2
    Log    Verified that 2 products are present in the cart.

their prices, quantity, and total price should be correct
    Element Text Should Be    ${cart_page.product_1_price}       Rs. 500
    Element Text Should Be    ${cart_page.product_1_quantity}    1
    Element Text Should Be    ${cart_page.product_1_total}       Rs. 500
    Element Text Should Be    ${cart_page.product_2_price}       Rs. 400
    Element Text Should Be    ${cart_page.product_2_quantity}    1
    Element Text Should Be    ${cart_page.product_2_total}       Rs. 400

Open first home page product details
    Scroll Element Into View    ${home_page.blue_top_view_product}
    Wait Until Element Is Visible    ${home_page.blue_top_view_product}
    Click Element    ${home_page.blue_top_view_product}

Set product quantity to "${quantity}"
    Wait Until Element Is Visible    ${product_details_page.quantity_input}
    Double Click Element    ${product_details_page.quantity_input}
    Input Text    ${product_details_page.quantity_input}    ${quantity}

Add product to cart
    Click Element    ${product_details_page.add_to_cart_btn}

The product should be displayed in the cart with quantity "${expected_qty}"
    Wait Until Element Is Visible    ${cart_page.product_1_quantity}
    Element Text Should Be    ${cart_page.product_1_quantity}    ${expected_qty}

Add searched products to cart
    ${buttons}    Get WebElements    ${products_page.add_to_cart_buttons}
    FOR    ${button}    IN    @{buttons}
        Click Element    ${button}
        Wait Until Element Is Visible    ${products_page.continue_shopping_btn}
        Click Element    ${products_page.continue_shopping_btn}
    END

Reset Browser State
    Delete All Cookies
    Execute Javascript    window.localStorage.clear();
    Execute Javascript    window.sessionStorage.clear();
    Reload Page

Add products to cart
    Wait Until Element Is Visible    ${products_page.add_to_cart_1}
    Click Element                    ${products_page.add_to_cart_1}
    Wait Until Element Is Visible    ${products_page.continue_shopping_btn}
    Click Element                    ${products_page.continue_shopping_btn}

Proceed to checkout
    Wait Until Element Is Visible    ${checkout_page.proceed_to_checkout_btn}
    Click Element                    ${checkout_page.proceed_to_checkout_btn}

Start registration from checkout
    Wait Until Element Is Visible    ${checkout_page.register_login_modal_link}
    Click Element                    ${checkout_page.register_login_modal_link}

Proceed to checkout again
    Click Element    ${checkout_page.proceed_to_checkout_btn}

Verify address details and review order
    Wait Until Element Is Visible    ${checkout_page.address_details_header}
    Wait Until Element Is Visible    ${checkout_page.review_order_header}

Enter comment and place order
    Input Text       ${checkout_page.comment_textarea}    Order for testing purpose.
    Click Element    ${checkout_page.place_order_btn}

Enter payment details and confirm order
    Wait Until Element Is Visible    ${payment_page.name_on_card_input}
    Input Text    ${payment_page.name_on_card_input}    Test Card
    Input Text    ${payment_page.card_number_input}    4111111111111111
    Input Text    ${payment_page.cvc_input}    123
    Input Text    ${payment_page.expiry_month_input}    01
    Input Text    ${payment_page.expiry_year_input}    2030
    Click Element    ${payment_page.pay_button}

Verify order placed success message
    Wait Until Element Is Visible    ${order_placed_page.continue_btn}
    Page Should Contain    Congratulations! Your order has been confirmed!

Verify product is in cart
    Wait Until Element Is Visible    ${cart_page.cart_rows}

Remove product from cart
    Wait Until Element Is Visible    ${cart_page.delete_btn}
    Click Element    ${cart_page.delete_btn}

The product should be removed from the cart
    Wait Until Element Is Visible    ${cart_page.empty_cart_msg}
    Page Should Not Contain Element  ${cart_page.cart_rows}

The category sidebar should be visible
    Wait Until Element Is Visible    ${sidebar.category_header}
    Element Should Contain    ${sidebar.category_header}    CATEGORY

The brands sidebar should be visible
    Scroll Element Into View    ${sidebar.brands_header}
    Wait Until Element Is Visible    ${sidebar.brands_header}
    Element Should Contain    ${sidebar.brands_header}    BRANDS

Open "${main_category}" > "${sub_category}" category
    ${main_locator}    Replace String    ${sidebar.main_category_link}    {}    ${main_category}
    Scroll Element Into View    ${main_locator}
    Click Element    ${main_locator}
    ${sub_locator_temp}    Replace String    ${sidebar.sub_category_link}    {}    ${main_category}    count=1
    ${sub_locator}    Replace String    ${sub_locator_temp}    {}    ${sub_category}
    Wait Until Element Is Visible    ${sub_locator}    timeout=5s
    Click Element    ${sub_locator}

Filter products by brand "${brand_name}"
    ${brand_locator}    Replace String    ${sidebar.brand_link}    {}    ${brand_name}
    Scroll Element Into View    ${brand_locator}
    Click Element    ${brand_locator}

The "${expected_title}" catalog should be displayed
    ${header_locator}    Replace String    ${catalog.page_header}    {}    ${expected_title}
    Wait Until Element Is Visible    ${header_locator}    timeout=5s
    Page Should Contain Element    ${header_locator}

Verify "Write Your Review" section
    Wait Until Element Is Visible    ${product_details_page.review_header}
    Element Should Be Visible    ${product_details_page.review_header}

Submit valid product review
    ${name}    FakerLibrary.Name
    ${email}   FakerLibrary.Email
    ${review}  FakerLibrary.Sentence
    Input Text    ${product_details_page.review_name_input}    ${name}
    Input Text    ${product_details_page.review_email_input}   ${email}
    Input Text    ${product_details_page.review_text_input}    ${review}
    Click Button  ${product_details_page.review_submit_btn}

Verify review success message
    Wait Until Element Is Visible    ${product_details_page.review_success_msg}
    Capture Page Screenshot
    Element Text Should Be    ${product_details_page.review_success_msg}    Thank you for your review.

Scroll to bottom of page
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight)

Verify "RECOMMENDED ITEMS" section
    Scroll Element Into View         ${home_page.recommended_items_header}
    Wait Until Element Is Visible    ${home_page.recommended_items_header}
    Element Should Be Visible    ${home_page.recommended_items_header}

Add recommended product to cart
    Wait Until Element Is Visible    ${home_page.recommended_add_to_cart}
    Click Element    ${home_page.recommended_add_to_cart}

The recommended product should be displayed in the cart
    Wait Until Element Is Visible    ${cart_page.cart_rows}
    Page Should Contain Element    ${cart_page.cart_rows}
    Element Text Should Be    ${cart_page.product_1_price}       Rs. 500
    Element Text Should Be    ${cart_page.product_1_quantity}    1
    Element Text Should Be    ${cart_page.product_1_total}       Rs. 500

Verify delivery and billing address match registration address
    Wait Until Element Is Visible    ${checkout_page.delivery_address_firstname}
    Element Should Contain    ${checkout_page.delivery_address_firstname}    ${FIRST_NAME} ${LAST_NAME}
    Element Should Contain    ${checkout_page.delivery_address_company}      ${COMPANY}
    Element Should Contain    ${checkout_page.delivery_address_address1}     ${ADDRESS1}
    Element Should Contain    ${checkout_page.delivery_address_address2}     ${ADDRESS2}
    Element Should Contain    ${checkout_page.delivery_address_city}         ${CITY} ${STATE} ${ZIPCODE}
    Element Should Contain    ${checkout_page.delivery_address_country}      United States
    Element Should Contain    ${checkout_page.delivery_address_phone}        ${MOBILE_NUMBER}
    Wait Until Element Is Visible    ${checkout_page.billing_address_firstname}
    Element Should Contain    ${checkout_page.billing_address_firstname}    ${FIRST_NAME} ${LAST_NAME}
    Element Should Contain    ${checkout_page.billing_address_company}      ${COMPANY}
    Element Should Contain    ${checkout_page.billing_address_address1}     ${ADDRESS1}
    Element Should Contain    ${checkout_page.billing_address_address2}     ${ADDRESS2}
    Element Should Contain    ${checkout_page.billing_address_city}         ${CITY} ${STATE} ${ZIPCODE}
    Element Should Contain    ${checkout_page.billing_address_country}      United States
    Element Should Contain    ${checkout_page.billing_address_phone}        ${MOBILE_NUMBER}

Download invoice
    Wait Until Element Is Visible    ${order_placed_page.download_invoice_btn}
    Click Element    ${order_placed_page.download_invoice_btn}

invoice is downloaded successfully
    ${file_path}    Set Variable    ${EXECDIR}/invoice.txt

    Wait Until Keyword Succeeds
    ...    5 sec
    ...    1 sec
    ...    File Should Exist
    ...    ${file_path}

    Remove File    ${file_path}

Click "Continue" button
    Click Element    ${order_placed_page.continue_btn}

the "SUBSCRIPTION" section should be visible
    Wait Until Element Is Visible    ${footer.subscription_header}
    Element Should Contain           ${footer.subscription_header}    SUBSCRIPTION

Scroll up using arrow button
    Wait Until Element Is Visible    ${home_page.scroll_up_arrow}
    Click Element    ${home_page.scroll_up_arrow}

the page should be scrolled to the top
    Wait Until Element Is Visible    ${home_page.full_fledged_text}
    Element Should Be Visible    ${home_page.full_fledged_text}

Scroll to top of page
    Execute Javascript    window.scrollTo(0, 0)


# ==============================================================================
# SECTION 2 — GIVEN/WHEN/THEN ORCHESTRATORS
# Shared helpers and test-case-facing keywords.
# Each keyword calls Section 1 steps directly.
# ==============================================================================

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

I add the first and second products to the cart
    Add first product to cart
    Continue shopping
    Add second product to cart

I subscribe to the newsletter
    Scroll down to footer
    ${random_email}    FakerLibrary.Email
    Input Text         ${footer.email_input}    ${random_email}
    Click Button       ${footer.submit_btn}

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

# --- Products ---

I am on the all products page
    Open automation exercise homepage
    Open Products page
    Verify redirection to All Products page

I am viewing a product's details
    Open automation exercise homepage
    Open Products page
    Verify redirection to All Products page
    Open first product details
    Verify product detail page is open

I view a product's details
    Open first product details

I should see the correct product details
    Verify product detail page is open
    Verify product details are visible

products matching "${term}" should be displayed
    Verify Searched Products section
    Verify products related to "${term}"

I submit a review
    Verify "Write Your Review" section
    Submit valid product review

# --- Cart ---

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

# --- Scroll ---

I scroll to the bottom and then to the top using the arrow
    Scroll to bottom of page
    the "SUBSCRIPTION" section should be visible
    Scroll up using arrow button

I scroll to the bottom and then back to the top
    Scroll to bottom of page
    the "SUBSCRIPTION" section should be visible
    Scroll to top of page
