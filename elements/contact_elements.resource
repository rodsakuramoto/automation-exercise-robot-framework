*** Variables ***
&{contact_us_page}
...    header=xpath://h2[contains(text(), 'Get In Touch')]
...    name_input=xpath://input[@data-qa='name']
...    email_input=xpath://input[@data-qa='email']
...    subject_input=xpath://input[@data-qa='subject']
...    message_textarea=xpath://textarea[@data-qa='message']
...    upload_file_input=xpath://input[@name='upload_file']
...    submit_button=xpath://input[@data-qa='submit-button']
...    success_msg=xpath://div[contains(@class, 'status') and contains(text(), 'Success!')]
