require 'test_helper'

Expectations do
  expect "From: gmail_account_name@gmail.com\nTo: to@gmail.com\nSubject: subject\n\nbody\n" do
    gmail_sender = GmailSender.new("gmail_account_name", "gmail_account_password")
    gmail_sender.create_message("to@gmail.com", "subject", "body")
  end
end
