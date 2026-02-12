*** Variables ***
&{home_page}
...    signup_login_btn=xpath://a[contains(text(), 'Signup / Login')]
...    home_logo=xpath://div[@class='logo pull-left']//img
...    home_link=xpath://a[contains(text(), 'Home')]
...    products_link=xpath://a[contains(text(), 'Products')]
...    cart_link=xpath://a[contains(text(), 'Cart')]
...    test_cases_link=xpath://a[contains(text(), 'Test Cases')]
...    api_testing_link=xpath://a[contains(text(), 'API Testing')]
...    video_tutorials_link=xpath://a[contains(text(), 'Video Tutorials')]
...    contact_us_link=xpath://a[contains(text(), 'Contact us')]
...    test_cases_btn=xpath://button[contains(text(), 'Test Cases')]
...    apis_list_btn=xpath://button[contains(text(), 'APIs list for practice')]
...    slider_img=xpath://div[@class='item active']//img
...    category_heading=xpath://h2[contains(text(), 'Category')]
...    women_category=xpath://a[normalize-space()='Women']
...    men_category=xpath://a[normalize-space()='Men']
...    kids_category=xpath://a[normalize-space()='Kids']
...    brands_heading=xpath://h2[contains(text(), 'Brands')]
...    polo_brand=xpath://a[contains(@href, '/brand_products/Polo')]
...    hm_brand=xpath://a[contains(@href, '/brand_products/H&M')]
...    features_items_heading=xpath://h2[contains(text(), 'Features Items')]
...    blue_top_product=xpath://div[@class='productinfo text-center']//p[text()='Blue Top']
...    blue_top_view_product=xpath://a[contains(@href, '/product_details/1')]
...    men_tshirt_product=xpath://div[@class='productinfo text-center']//p[text()='Men Tshirt']
...    sleeveless_dress_product=xpath://div[@class='productinfo text-center']//p[text()='Sleeveless Dress']
...    recommended_items_header=xpath://h2[contains(text(), 'recommended items')]
...    recommended_add_to_cart=xpath:(//div[contains(@class, 'recommended_items')]//a[contains(@class, 'add-to-cart')])[1]
...    scroll_up_arrow=id:scrollUp
...    full_fledged_text=xpath://div[@class='item active']//h2[contains(text(), 'Full-Fledged practice website for Automation Engineers')]

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

&{contact_us_page}
...    header=xpath://h2[contains(text(), 'Get In Touch')]
...    name_input=xpath://input[@data-qa='name']
...    email_input=xpath://input[@data-qa='email']
...    subject_input=xpath://input[@data-qa='subject']
...    message_textarea=xpath://textarea[@data-qa='message']
...    upload_file_input=xpath://input[@name='upload_file']
...    submit_button=xpath://input[@data-qa='submit-button']
...    success_msg=xpath://div[contains(@class, 'status') and contains(text(), 'Success!')]

&{test_cases_page}
...    header=xpath://h2[contains(., 'Test Cases')][1]
...    list_container=xpath://div[@class='panel-group']

&{products_page}
...    header=xpath://h2[contains(text(), 'All Products')]
...    products_list=xpath://div[@class='features_items']
...    first_product_view_btn=xpath://a[@href='/product_details/1']
...    search_input=id:search_product
...    search_btn=id:submit_search
...    searched_products_header=xpath://h2[contains(text(), 'Searched Products')]
...    product_names=xpath://div[@class='productinfo text-center']//p
...    add_to_cart_1=xpath:(//a[@data-product-id='1' and @class='btn btn-default add-to-cart'])[1]
...    add_to_cart_2=xpath:(//a[@data-product-id='2' and @class='btn btn-default add-to-cart'])[1]
...    continue_shopping_btn=xpath://button[contains(text(), 'Continue Shopping')]
...    view_cart_modal_link=xpath://u[contains(text(), 'View Cart')]
...    add_to_cart_buttons=xpath://div[@class='productinfo text-center']//a[contains(@class,'add-to-cart')]

&{product_details_page}
...    product_name=xpath://div[@class='product-information']//h2
...    category=xpath://div[@class='product-information']//p[contains(text(), 'Category')]
...    price=xpath://div[@class='product-information']//span/span
...    availability=xpath://div[@class='product-information']//b[contains(text(), 'Availability')]
...    condition=xpath://div[@class='product-information']//b[contains(text(), 'Condition')]
...    brand=xpath://div[@class='product-information']//b[contains(text(), 'Brand')]
...    quantity_input=id:quantity
...    add_to_cart_btn=xpath://button[@type='button']//i[contains(@class, 'fa-shopping-cart')]/..
...    view_cart_modal_link=xpath://u[contains(text(), 'View Cart')]
...    review_header=xpath://a[contains(text(), 'Write Your Review')]
...    review_name_input=id:name
...    review_email_input=id:email
...    review_text_input=id:review
...    review_submit_btn=id:button-review
...    review_success_msg=xpath://span[contains(text(), 'Thank you for your review.')]

&{cart_page}
...    breadcrumb=xpath://li[@class='active' and contains(text(), 'Shopping Cart')]
...    cart_rows=xpath://tr[contains(@id, 'product-')]
...    product_1_price=xpath://tr[@id='product-1']//td[@class='cart_price']
...    product_1_quantity=xpath://tr[@id='product-1']//button[@class='disabled']
...    product_1_total=xpath://tr[@id='product-1']//p[@class='cart_total_price']
...    product_2_price=xpath://tr[@id='product-2']//td[@class='cart_price']
...    product_2_quantity=xpath://tr[@id='product-2']//button[@class='disabled']
...    product_2_total=xpath://tr[@id='product-2']//p[@class='cart_total_price']
...    delete_btn=xpath://a[@class='cart_quantity_delete']
...    empty_cart_msg=xpath://b[contains(text(), 'Cart is empty!')]

&{footer}
...    subscription_header=xpath://h2[contains(text(), 'Subscription')]
...    email_input=id:susbscribe_email
...    submit_btn=id:subscribe
...    success_msg=xpath://div[@id='success-subscribe']//div[contains(text(), 'You have been successfully subscribed!')]

&{checkout_page}
...    proceed_to_checkout_btn=xpath://a[contains(text(), 'Proceed To Checkout')]
...    register_login_modal_link=xpath://u[contains(text(), 'Register / Login')]
...    address_details_header=xpath://h2[contains(text(), 'Address Details')]
...    review_order_header=xpath://h2[contains(text(), 'Review Your Order')]
...    comment_textarea=xpath://textarea[@name='message']
...    place_order_btn=xpath://a[contains(text(), 'Place Order')]
...    delivery_address_firstname=xpath://ul[@id='address_delivery']//li[contains(@class, 'address_firstname')]
...    delivery_address_company=xpath://ul[@id='address_delivery']//li[3]
...    delivery_address_address1=xpath://ul[@id='address_delivery']//li[4]
...    delivery_address_address2=xpath://ul[@id='address_delivery']//li[5]
...    delivery_address_city=xpath://ul[@id='address_delivery']//li[contains(@class, 'address_city')]
...    delivery_address_country=xpath://ul[@id='address_delivery']//li[contains(@class, 'address_country')]
...    delivery_address_phone=xpath://ul[@id='address_delivery']//li[contains(@class, 'address_phone')]
...    billing_address_firstname=xpath://ul[@id='address_invoice']//li[contains(@class, 'address_firstname')]
...    billing_address_company=xpath://ul[@id='address_invoice']//li[3]
...    billing_address_address1=xpath://ul[@id='address_invoice']//li[4]
...    billing_address_address2=xpath://ul[@id='address_invoice']//li[5]
...    billing_address_city=xpath://ul[@id='address_invoice']//li[contains(@class, 'address_city')]
...    billing_address_country=xpath://ul[@id='address_invoice']//li[contains(@class, 'address_country')]
...    billing_address_phone=xpath://ul[@id='address_invoice']//li[contains(@class, 'address_phone')]

&{payment_page}
...    name_on_card_input=xpath://input[@name='name_on_card']
...    card_number_input=xpath://input[@name='card_number']
...    cvc_input=xpath://input[@name='cvc']
...    expiry_month_input=xpath://input[@name='expiry_month']
...    expiry_year_input=xpath://input[@name='expiry_year']
...    pay_button=id:submit

&{order_placed_page}
...    continue_btn=xpath://a[contains(text(), 'Continue')]
...    download_invoice_btn=xpath://a[contains(text(), 'Download Invoice')]

&{sidebar}
...    category_header=xpath://h2[contains(text(), 'Category')]
...    women_category_link=xpath://a[normalize-space()='Women']
...    men_category_link=xpath://a[normalize-space()='Men']
...    kids_category_link=xpath://a[normalize-space()='Kids']
...    women_dress_link=xpath://div[@id='Women']//a[contains(text(), 'Dress')]
...    women_tops_link=xpath://div[@id='Women']//a[contains(text(), 'Tops')]
...    men_tshirts_link=xpath://div[@id='Men']//a[contains(text(), 'Tshirts')]
...    men_jeans_link=xpath://div[@id='Men']//a[contains(text(), 'Jeans')]
...    brands_header=xpath://h2[contains(text(), 'Brands')]
...    polo_brand_link=xpath://a[@href='/brand_products/Polo']
...    hm_brand_link=xpath://a[@href='/brand_products/H&M']
...    madame_brand_link=xpath://a[@href='/brand_products/Madame']
...    main_category_link=xpath://a[normalize-space()='{}']
...    sub_category_link=xpath://div[@id='{}']//a[contains(text(), '{}')]
...    brand_link=xpath://div[@class='brands-name']//a[contains(normalize-space(), '{}')]

&{category_products_page}
...    header_women_dress=xpath://h2[contains(text(), 'Women - Dress Products')]
...    header_men_tshirts=xpath://h2[contains(text(), 'Men - Tshirts Products')]
...    generic_header=xpath://h2[@class='title text-center']

&{catalog}
...    page_header=xpath://h2[@class='title text-center' and contains(text(), '{}')]