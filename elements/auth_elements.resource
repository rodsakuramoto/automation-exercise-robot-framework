*** Variables ***
&{login_signup_page}
...    signup_name_input=xpath://input[@data-qa='signup-name']
...    signup_email_input=xpath://input[@data-qa='signup-email']
...    signup_btn=xpath://button[@data-qa='signup-button']
...    login_header=xpath://h2[contains(text(), 'Login to your account')]
...    login_email_input=xpath://input[@data-qa='login-email']
...    login_password_input=xpath://input[@data-qa='login-password']
...    login_btn=xpath://button[@data-qa='login-button']
...    signup_header=xpath://h2[contains(text(), 'New User Signup!')]
...    login_error_msg=xpath://p[contains(text(), 'Your email or password is incorrect!')]
...    signup_error_msg=xpath://p[contains(text(), 'Email Address already exist!')]

&{account_info_page}
...    account_info_text=xpath://b[contains(text(), 'Enter Account Information')]
...    gender_male_radio=id:id_gender1
...    gender_female_radio=id:id_gender2
...    password_input=id:password
...    day_select=id:days
...    month_select=id:months
...    year_select=id:years
...    newsletter_checkbox=id:newsletter
...    optin_checkbox=id:optin
...    first_name_input=id:first_name
...    last_name_input=id:last_name
...    company_input=id:company
...    address1_input=id:address1
...    address2_input=id:address2
...    country_select=id:country
...    state_input=id:state
...    city_input=id:city
...    zipcode_input=id:zipcode
...    mobile_number_input=id:mobile_number
...    create_account_btn=xpath://button[@data-qa='create-account']

&{account_created_deleted}
...    account_created_msg=xpath://h2[@data-qa='account-created']
...    continue_btn=xpath://a[@data-qa='continue-button']
...    logout_btn=xpath://a[contains(text(), 'Logout')]
...    logged_in_as_text=xpath://a[contains(., 'Logged in as user_name')]
...    delete_account_btn=xpath://a[contains(text(), 'Delete Account')]
...    account_deleted_msg=xpath://h2[@data-qa='account-deleted']
