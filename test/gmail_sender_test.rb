require 'test_helper'

Expectations do
  expect "From: gmail_account_name@gmail.com\nTo: to@gmail.com\nSubject: subject\n\nbody\n" do
    gmail_sender = GmailSender.new("gmail_account_name", "gmail_account_password")
    string_io = StringIO.new
    gmail_sender.set_message_stream(string_io, "to@gmail.com", "subject", "body")
    string_io.string
  end
end
