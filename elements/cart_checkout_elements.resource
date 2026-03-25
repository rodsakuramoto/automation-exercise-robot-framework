*** Variables ***
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
