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

    Set Test Variable    ${USER_NAME}    ${user_name}
    Set Test Variable    ${USER_EMAIL}   ${user_email}

    @{user_name_parts}    Split String
    ...    string=${user_name}
    ...    separator=${SPACE}

    Set Test Variable    ${FIRST_NAME}    ${user_name_parts}[0]
    ${parts_length}=     Get Length       ${user_name_parts}
    ${last_name_val}=    Run Keyword If   ${parts_length} > 1    Set Variable    ${user_name_parts}[1]    ELSE    Set Variable    ${user_name_parts}[0]
    Set Test Variable    ${LAST_NAME}     ${last_name_val}

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

    Set Test Variable    ${USER_PASSWORD}    ${user_password}

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
    I am on the automation exercise homepage
    I start the new user login/signup process
    I enter valid name and email address
    I fill in the account information and address details
    I confirm the account creation
    the account should be created successfully
    I should see that I am logged in
    Capture Page Screenshot
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

I logout of the account
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

I return to the home page
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

I view the details of the first product
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

I subscribe to the newsletter
    I scroll down to the footer
    ${random_email}    FakerLibrary.Email
    Input Text         ${footer.email_input}    ${random_email}
    Click Button       ${footer.submit_btn}

I should see the subscription success message
    Wait Until Element Is Visible    ${footer.success_msg}
    Element Should Contain           ${footer.success_msg}    You have been successfully subscribed!

I navigate to the Cart page
    Wait Until Element Is Enabled    ${home_page.cart_link}    timeout=5s
    Click Element                    ${home_page.cart_link}
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

I add the first and second products to the cart
    I add the first product to the cart
    I continue shopping
    I add the second product to the cart

I view the cart
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

I view the details of the first product on the home page
    Scroll Element Into View    ${home_page.blue_top_view_product}
    Wait Until Element Is Visible    ${home_page.blue_top_view_product}
    Click Element    ${home_page.blue_top_view_product}

I set the product quantity to "${quantity}"
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

I initiate registration from checkout
    Wait Until Element Is Visible    ${checkout_page.register_login_modal_link}
    Click Element                    ${checkout_page.register_login_modal_link}

I register a new account successfully
    I start the new user login/signup process
    I enter valid name and email address
    I fill in the account information and address details
    I confirm the account creation
    the account should be created successfully

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

I submit a valid product review
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

the "SUBSCRIPTION" section should be visible
    Wait Until Element Is Visible    ${footer.subscription_header}
    Element Should Contain           ${footer.subscription_header}    SUBSCRIPTION

I scroll up using the arrow button
    Wait Until Element Is Visible    ${home_page.scroll_up_arrow}
    Click Element    ${home_page.scroll_up_arrow}

the page should be scrolled to the top
    Wait Until Element Is Visible    ${home_page.full_fledged_text}
    Element Should Be Visible    ${home_page.full_fledged_text}

I scroll up to the top of the page
    Execute Javascript    window.scrollTo(0, 0)

I login with valid credentials
    I start the new user login/signup process
    I enter correct email and password
    I click login button

I complete the payment process
    I enter a comment and place the order
    I enter payment details and confirm the order
    I should see the order placed success message

I place an order as a newly registered user
    I add products to the cart
    I navigate to the Cart page
    I proceed to checkout
    I initiate registration from checkout
    I register a new account successfully
    I should see that I am logged in
    I navigate to the Cart page
    I proceed to checkout again
    I should see the address details and review order
    I complete the payment process
    Capture Page Screenshot

I attempt to login with invalid credentials
    I start the new user login/signup process
    I enter incorrect email and password
    I click login button

I attempt to register with an existing email
    I start the new user login/signup process
    I enter an existing name and email address
    I click signup button

I register a new user
    I start the new user login/signup process
    I enter valid name and email address
    I fill in the account information and address details
    I confirm the account creation

I should be successfully registered and logged in
    the account should be created successfully
    I should see that I am logged in

I should be logged in
    I should see that I am logged in

I should see an invalid credentials error message
    I should see a error message of incorrect email or password

I am logged in
    Create user account
    I am on the automation exercise homepage
    I login with valid credentials
    I should be logged in

I log out
    I logout of the account

I am on the signup page
    I am on the automation exercise homepage
    I start the new user login/signup process

I should see an email exists error message
    I should see a error message that email address already exist

I add two products to the cart
    I navigate to the Products page
    I add the first and second products to the cart
    I view the cart

The cart should contain two products with correct details
    both products should be added to the cart
    their prices, quantity, and total price should be correct

I am on the product detail page of a product
    I am on the automation exercise homepage
    I view the details of the first product on the home page
    I should be landed on the product detail page

I add "${quantity}" units of the product to the cart
    I set the product quantity to "${quantity}"
    I add the product to the cart
    I view the cart

The cart should show the product with quantity "${quantity}"
    The product should be displayed in the cart with quantity "${quantity}"

A product is in the cart
    I am on the automation exercise homepage
    I add products to the cart
    I navigate to the Cart page

I checkout as a new user and place the order
    I proceed to checkout
    I initiate registration from checkout
    I register a new account successfully
    I should see that I am logged in
    I navigate to the Cart page
    I proceed to checkout again
    I should see the address details and review order
    I complete the payment process

I add a product to the cart and checkout to place the order
    I add products to the cart
    I navigate to the Cart page
    I proceed to checkout
    I should see the address details and review order
    I complete the payment process

The order should be confirmed
    I should see the order placed success message

I am registered and logged in
    I am on the automation exercise homepage
    I register a new account successfully
    I should see that I am logged in

The cart should be empty
    The product should be removed from the cart

I search for a product and add it to the cart
    I navigate to the Products page
    I should be redirected to the All Products page
    I search for the product "Men Tshirt"
    products matching "Men Tshirt" should be displayed
    I add the searched products to the cart
    I navigate to the Cart page
    I should see the product in the cart

I log in
    I login with valid credentials

The product should still be in my cart
    I navigate to the Cart page
    I should see the product in the cart

I am a registered user with products in the cart
    I am on the automation exercise homepage
    I register a new account successfully
    I should see that I am logged in
    I add products to the cart
    I navigate to the Cart page
    I should see the product in the cart

My address details should be pre-filled correctly
    I should see the address details and review order
    I verify that the delivery and billing address is the same as the registration address

I have placed an order
    I am on the automation exercise homepage
    I place an order as a newly registered user

The invoice should be downloaded successfully
    invoice is downloaded successfully
    I click the "Continue" button

I submit the contact us form with valid details
    I navigate to the Contact Us page
    I submit the contact form with valid details and a file

I should see a success message and be able to return home
    I should see the success message
    I return to the home page

I add a recommended item to the cart
    I should see the "RECOMMENDED ITEMS" section
    I add a recommended product to the cart
    I view the cart

The item should appear in the cart
    The recommended product should be displayed in the cart

I scroll to the bottom and then to the top using the arrow
    I scroll to the bottom of the page
    the "SUBSCRIPTION" section should be visible
    I scroll up using the arrow button

The page should scroll accordingly
    the page should be scrolled to the top

I scroll to the bottom and then back to the top
    I scroll to the bottom of the page
    the "SUBSCRIPTION" section should be visible
    I scroll up to the top of the page

I am on the all products page
    I am on the automation exercise homepage
    I navigate to the Products page
    I should be redirected to the All Products page

I view a product's details
    I view the details of the first product

I should see the correct product details
    I should be landed on the product detail page
    I should see the product details including name, category, price, availability, condition, and brand

products matching "${term}" should be displayed
    I should see the Searched Products section
    I should see products related to "${term}"

I navigate to the "${main}" > "${sub}" category
    I browse to the "${main}" > "${sub}" category

I should see the "${title}" catalog
    The "${title}" catalog should be displayed

I filter by brand "${brand}"
    I filter products by the brand "${brand}"

I am viewing a product's details
    I am on the all products page
    I view the details of the first product
    I should be landed on the product detail page

I submit a review
    I should see the "Write Your Review" section
    I submit a valid product review

I should see a success message for the review
    I should see the review success message

I am on the cart page
    I am on the automation exercise homepage
    I navigate to the Cart page

I should see a subscription success message
    I should see the subscription success message

I navigate to the Test Cases page
    I navigate to the Test Cases section

I should see the test cases page
    the test cases catalog should be accessible
