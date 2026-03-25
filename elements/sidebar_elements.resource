*** Variables ***
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
