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


*** Keywords ***
Launch browser
    ${prefs}=    Create Dictionary    download.default_directory=${EXECDIR}    download.prompt_for_download=${FALSE}
    Open Browser    browser=chrome    options=add_experimental_option("prefs", ${prefs});add_argument("--disable-notifications");add_argument("--disable-popup-blocking");add_argument("--no-sandbox");add_argument("--disable-dev-shm-usage");add_argument("--headless");add_argument("--host-resolver-rules=MAP *googleadservices.com 0.0.0.0, MAP *googlesyndication.com 0.0.0.0, MAP *g.doubleclick.net 0.0.0.0")
    Set Window Size    1920    1080

I am on the automation exercise homepage
    Go To  url=${URL}
    Title Should Be    Automation Exercise
    Wait Until Element Is Visible    ${home_page.home_logo}
    # Performance: Only wait for the main element. Check existence of others without explicit waits.
    Page Should Contain Element    ${home_page.signup_login_btn}

I start the new user login/signup process
    Click Element    ${home_page.signup_login_btn}
    Wait Until Element Is Visible    ${login_signup_page.signup_header}
    Wait Until Element Is Visible    ${login_signup_page.signup_name_input}
    Wait Until Element Is Visible    ${login_signup_page.signup_email_input}
    Wait Until Element Is Visible    ${login_signup_page.login_header}
    Wait Until Element Is Visible    ${login_signup_page.login_email_input}
    Wait Until Element Is Visible    ${login_signup_page.login_password_input}
    Wait Until Element Is Visible    ${login_signup_page.login_btn}

I enter valid name and email address
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


    Set Test Variable    ${USER_NAME}
    Set Test Variable    ${USER_EMAIL}

    @{user_name}    Split String
    ...    string=${user_name}
    ...    separator=${SPACE}

    ${FIRST_NAME}   Set Variable    ${USER_NAME}[0]
    ${LAST_NAME}   Set Variable    ${USER_NAME}[1]

    Set Test Variable    ${FIRST_NAME}
    Set Test Variable    ${LAST_NAME}

I fill in the account information and address details
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

    Set Test Variable    ${USER_PASSWORD}

    Set Test Variable    ${COMPANY}    ${company}
    Set Test Variable    ${ADDRESS1}    ${address1}
    Set Test Variable    ${ADDRESS2}    ${address2}
    Set Test Variable    ${STATE}    ${state}
    Set Test Variable    ${CITY}    ${city}
    Set Test Variable    ${ZIPCODE}    ${zipcode}
    Set Test Variable    ${MOBILE_NUMBER}    ${mobile_number}

I confirm the account creation
    Click Element    ${account_info_page.create_account_btn}
    Capture Page Screenshot

the account should be created successfully
    Wait Until Element Is Visible    ${account_created_deleted.account_created_msg}
    Click Element    ${account_created_deleted.continue_btn}

I should see that I am logged in
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

Create user account
    Run Keywords
    ...    I am on the automation exercise homepage
    ...    I start the new user login/signup process
    ...    I enter valid name and email address
    ...    I fill in the account information and address details
    ...    I confirm the account creation
    ...    the account should be created successfully
    Capture Page Screenshot
    ...    I should see that I am logged in

    Click Element    ${account_created_deleted.logout_btn}

I enter correct email and password
    Input Text    ${login_signup_page.login_email_input}    ${USER_EMAIL}
    Input Text    ${login_signup_page.login_password_input}    ${USER_PASSWORD}

I click login button
    Click Element    ${login_signup_page.login_btn}

I enter incorrect email and password
    Input Text    ${login_signup_page.login_email_input}    incorrect_email@example.com
    Input Text    ${login_signup_page.login_password_input}    wrong_password

I should see a error message of incorrect email or password
    Wait Until Element Is Visible    ${login_signup_page.login_error_msg}
    Element Text Should Be    ${login_signup_page.login_error_msg}    Your email or password is incorrect!

I click logout button
    Click Element    ${account_created_deleted.logout_btn}

I should be redirected to the login page
    Wait Until Element Is Visible    ${login_signup_page.login_header}
    Wait Until Element Is Visible    ${login_signup_page.signup_header}
    Wait Until Element Is Visible    ${login_signup_page.signup_name_input}
    Wait Until Element Is Visible    ${login_signup_page.signup_email_input}
    Wait Until Element Is Visible    ${login_signup_page.login_header}
    Wait Until Element Is Visible    ${login_signup_page.login_email_input}
    Wait Until Element Is Visible    ${login_signup_page.login_password_input}
    Wait Until Element Is Visible    ${login_signup_page.login_btn}

I enter an existing name and email address
    Input Text    ${login_signup_page.signup_name_input}    ${USER_NAME}
    Input Text    ${login_signup_page.signup_email_input}    ${USER_EMAIL}

I click signup button
    Click Element    ${login_signup_page.signup_btn}

I should see a error message that email address already exist
    Wait Until Element Is Visible   ${login_signup_page.signup_error_msg}

I navigate to the Contact Us page
    Click Element    ${HOME_PAGE.contact_us_link}
    Page Should Contain    Get In Touch
    Wait Until Element Is Visible    ${contact_us_page.header}
    Element Should Be Visible        ${contact_us_page.name_input}
    Element Should Be Visible        ${contact_us_page.email_input}
    Element Should Be Visible        ${contact_us_page.subject_input}
    Element Should Be Visible        ${contact_us_page.message_textarea}
    Element Should Be Visible        ${contact_us_page.upload_file_input}
    Element Should Be Visible        ${contact_us_page.submit_button}

I submit the contact form with valid details and a file
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

I should see the success message
    Wait Until Element Is Visible    ${contact_us_page.success_msg}
    Page Should Contain    Success! Your details have been submitted successfully.

I should be able to return to the home page
    Click Element    ${home_page.home_link}
    Title Should Be    Automation Exercise
    Wait Until Element Is Visible    ${home_page.home_logo}
    Wait Until Element Is Visible    ${home_page.home_link}

I navigate to the Test Cases section
    Click Element    ${home_page.test_cases_link}

the test cases catalog should be accessible
    Title Should Be    Automation Practice Website for UI Testing - Test Cases
    Wait Until Element Is Visible    ${test_cases_page.list_container}
    Element Should Be Visible        ${test_cases_page.header}

I navigate to the Products page
    Click Element    ${home_page.products_link}

I should be redirected to the All Products page
    Title Should Be    Automation Exercise - All Products
    Wait Until Element Is Visible    ${products_page.header}
    Element Should Contain    ${products_page.header}    ALL PRODUCTS

The products list should be visible
    Wait Until Element Is Visible    ${products_page.products_list}

I click on View Product of the first product
    Wait Until Element Is Visible    ${products_page.first_product_view_btn}
    Click Element    ${products_page.first_product_view_btn}

I should be landed on the product detail page
    Title Should Be    Automation Exercise - Product Details
    Wait Until Element Is Visible    ${product_details_page.product_name}

I should see the product details including name, category, price, availability, condition, and brand
    Element Should Be Visible    ${product_details_page.product_name}
    Element Should Be Visible    ${product_details_page.category}
    Element Should Be Visible    ${product_details_page.price}
    Element Should Be Visible    ${product_details_page.availability}
    Element Should Be Visible    ${product_details_page.condition}
    Element Should Be Visible    ${product_details_page.brand}

I search for the product "${product_name}"
    Wait Until Element Is Visible    ${products_page.search_input}
    Input Text       ${products_page.search_input}    ${product_name}
    Click Button     ${products_page.search_btn}

I should see the Searched Products section
    Wait Until Element Is Visible    ${products_page.searched_products_header}
    Element Should Contain           ${products_page.searched_products_header}    SEARCHED PRODUCTS

I should see products related to "${search_term}"
    Wait Until Element Is Visible    ${products_page.products_list}
    Page Should Contain Element      ${products_page.product_names}
    Page Should Contain              ${search_term}

I scroll down to the footer
    Scroll Element Into View         ${footer.subscription_header}
    Wait Until Element Is Visible    ${footer.subscription_header}
    Element Should Contain           ${footer.subscription_header}    SUBSCRIPTION

I enter email address in subscription input and click arrow button
    ${random_email}    FakerLibrary.Email
    Input Text         ${footer.email_input}    ${random_email}
    Click Button       ${footer.submit_btn}

I should see the subscription success message
    Wait Until Element Is Visible    ${footer.success_msg}
    Element Should Contain           ${footer.success_msg}    You have been successfully subscribed!

I navigate to the Cart page
    Click Element    ${home_page.cart_link}
    Title Should Be    Automation Exercise - Checkout
    Wait Until Element Is Visible    ${cart_page.breadcrumb}

I add the first product to the cart
    Wait Until Element Is Visible    ${products_page.add_to_cart_1}
    Click Element                    ${products_page.add_to_cart_1}

I continue shopping
    Wait Until Element Is Visible    ${products_page.continue_shopping_btn}
    Click Element                    ${products_page.continue_shopping_btn}

I add the second product to the cart
    Wait Until Element Is Visible    ${products_page.add_to_cart_2}
    Click Element                    ${products_page.add_to_cart_2}

I view the cart
    Wait Until Element Is Visible    ${products_page.view_cart_modal_link}
    Click Element                    ${products_page.view_cart_modal_link}

Then both products should be added to the cart
    Title Should Be    Automation Exercise - Checkout
    Wait Until Element Is Visible    ${cart_page.cart_rows}
    ${count}=    Get Element Count   ${cart_page.cart_rows}
    Should Be Equal As Integers      ${count}    2
    Log    Verified that 2 products are present in the cart.

And their prices, quantity, and total price should be correct
    Element Text Should Be    ${cart_page.product_1_price}       Rs. 500
    Element Text Should Be    ${cart_page.product_1_quantity}    1
    Element Text Should Be    ${cart_page.product_1_total}       Rs. 500
    Element Text Should Be    ${cart_page.product_2_price}       Rs. 400
    Element Text Should Be    ${cart_page.product_2_quantity}    1
    Element Text Should Be    ${cart_page.product_2_total}       Rs. 400

I click on View Product for the first product
    Scroll Element Into View    ${home_page.blue_top_view_product}
    Wait Until Element Is Visible    ${home_page.blue_top_view_product}
    Click Element    ${home_page.blue_top_view_product}

I increase the quantity to "${quantity}"
    Wait Until Element Is Visible    ${product_details_page.quantity_input}
    Double Click Element    ${product_details_page.quantity_input}
    Input Text    ${product_details_page.quantity_input}    ${quantity}

I add the product to the cart
    Click Element    ${product_details_page.add_to_cart_btn}

The product should be displayed in the cart with quantity "${expected_qty}"
    Wait Until Element Is Visible    ${cart_page.product_1_quantity}
    Element Text Should Be    ${cart_page.product_1_quantity}    ${expected_qty}

I add the searched products to the cart
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

I add products to the cart
    Wait Until Element Is Visible    ${products_page.add_to_cart_1}
    Click Element                    ${products_page.add_to_cart_1}
    Wait Until Element Is Visible    ${products_page.continue_shopping_btn}
    Click Element                    ${products_page.continue_shopping_btn}

I proceed to checkout
    Wait Until Element Is Visible    ${checkout_page.proceed_to_checkout_btn}
    Click Element                    ${checkout_page.proceed_to_checkout_btn}

I choose to register or login from the checkout modal
    Wait Until Element Is Visible    ${checkout_page.register_login_modal_link}
    Click Element                    ${checkout_page.register_login_modal_link}

I register a new account successfully
    Run Keyword    I start the new user login/signup process
    Run Keyword    I enter valid name and email address
    Run Keyword    I fill in the account information and address details
    Run Keyword    I confirm the account creation
    Run Keyword    the account should be created successfully

I proceed to checkout again
    Click Element    ${checkout_page.proceed_to_checkout_btn}

I should see the address details and review order
    Wait Until Element Is Visible    ${checkout_page.address_details_header}
    Wait Until Element Is Visible    ${checkout_page.review_order_header}

I enter a comment and place the order
    Input Text       ${checkout_page.comment_textarea}    Order for testing purpose.
    Click Element    ${checkout_page.place_order_btn}

I enter payment details and confirm the order
    Wait Until Element Is Visible    ${payment_page.name_on_card_input}
    Input Text    ${payment_page.name_on_card_input}    Test Card
    Input Text    ${payment_page.card_number_input}    4111111111111111
    Input Text    ${payment_page.cvc_input}    123
    Input Text    ${payment_page.expiry_month_input}    01
    Input Text    ${payment_page.expiry_year_input}    2030
    Click Element    ${payment_page.pay_button}

I should see the order placed success message
    Wait Until Element Is Visible    ${order_placed_page.continue_btn}
    Page Should Contain    Congratulations! Your order has been confirmed!

I should see the product in the cart
    Wait Until Element Is Visible    ${cart_page.cart_rows}

I remove the product from the cart
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

I browse to the "${main_category}" > "${sub_category}" category
    ${main_locator}    Replace String    ${sidebar.main_category_link}    {}    ${main_category}
    Scroll Element Into View    ${main_locator}
    Click Element    ${main_locator}
    ${sub_locator_temp}    Replace String    ${sidebar.sub_category_link}    {}    ${main_category}    count=1
    ${sub_locator}    Replace String    ${sub_locator_temp}    {}    ${sub_category}
    Wait Until Element Is Visible    ${sub_locator}    timeout=5s
    Click Element    ${sub_locator}

I filter products by the brand "${brand_name}"
    ${brand_locator}    Replace String    ${sidebar.brand_link}    {}    ${brand_name}
    Scroll Element Into View    ${brand_locator}
    Click Element    ${brand_locator}

The "${expected_title}" catalog should be displayed
    ${header_locator}    Replace String    ${catalog.page_header}    {}    ${expected_title}
    Wait Until Element Is Visible    ${header_locator}    timeout=5s
    Page Should Contain Element    ${header_locator}

I should see the "Write Your Review" section
    Wait Until Element Is Visible    ${product_details_page.review_header}
    Element Should Be Visible    ${product_details_page.review_header}

I submit a review with name, email, and content
    ${name}    FakerLibrary.Name
    ${email}   FakerLibrary.Email
    ${review}  FakerLibrary.Sentence
    Input Text    ${product_details_page.review_name_input}    ${name}
    Input Text    ${product_details_page.review_email_input}   ${email}
    Input Text    ${product_details_page.review_text_input}    ${review}
    Click Button  ${product_details_page.review_submit_btn}

I should see the review success message
    Wait Until Element Is Visible    ${product_details_page.review_success_msg}
    Capture Page Screenshot
    Element Text Should Be    ${product_details_page.review_success_msg}    Thank you for your review.

I scroll to the bottom of the page
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight)

I should see the "RECOMMENDED ITEMS" section
    Scroll Element Into View         ${home_page.recommended_items_header}
    Wait Until Element Is Visible    ${home_page.recommended_items_header}
    Element Should Be Visible    ${home_page.recommended_items_header}

I add a recommended product to the cart
    Wait Until Element Is Visible    ${home_page.recommended_add_to_cart}
    Click Element    ${home_page.recommended_add_to_cart}

The recommended product should be displayed in the cart
    Wait Until Element Is Visible    ${cart_page.cart_rows}
    Page Should Contain Element    ${cart_page.cart_rows}
    Element Text Should Be    ${cart_page.product_1_price}       Rs. 500
    Element Text Should Be    ${cart_page.product_1_quantity}    1
    Element Text Should Be    ${cart_page.product_1_total}       Rs. 500

I verify that the delivery and billing address is the same as the registration address
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

I download the invoice
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

I click the "Continue" button
    Click Element    ${order_placed_page.continue_btn}

I verify "SUBSCRIPTION" is visible
    Wait Until Element Is Visible    ${footer.subscription_header}
    Element Should Contain           ${footer.subscription_header}    SUBSCRIPTION

I click on the scroll up arrow
    Wait Until Element Is Visible    ${home_page.scroll_up_arrow}
    Click Element    ${home_page.scroll_up_arrow}

I verify that the page is scrolled up and the full-fledged text is visible
    Wait Until Element Is Visible    ${home_page.full_fledged_text}
    Element Should Be Visible    ${home_page.full_fledged_text}

I scroll up to the top of the page
    Execute Javascript    window.scrollTo(0, 0)

I login with valid credentials
    Run Keywords
    ...    I start the new user login/signup process
    ...    I enter correct email and password
    ...    I click login button
    ...    I should see that I am logged in

I complete the payment process
    Run Keywords
    ...    I enter a comment and place the order
    ...    I enter payment details and confirm the order
    ...    I should see the order placed success message

I place an order as a newly registered user
    Run Keywords
    ...    I add products to the cart
    ...    I navigate to the Cart page
    ...    I proceed to checkout
    ...    I choose to register or login from the checkout modal
    ...    I register a new account successfully
    ...    I should see that I am logged in
    ...    I navigate to the Cart page
    ...    I proceed to checkout again
    ...    I should see the address details and review order
    ...    I complete the payment process
    ...    Capture Page Screenshot
