*** Variables ***
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
