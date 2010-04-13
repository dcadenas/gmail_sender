require 'test_helper'

class FakedNetSMTP
  def initialize(*args)
  end

  def start(*args)
    yield self
  end

  def enable_starttls
  end

  def open_message_stream(*args)
    stream = StringIO.new
    yield stream
    @@sent_email = stream.string
  end

  def self.sent_email
    @@sent_email
  end
end

Expectations do
  expect "From: me@gmail.com\nTo: someone@somehost.com\nSubject: hi!\nMIME-Version: 1.0\nContent-Type: text/plain; charset='utf-8'\n\nho\n" do
    gmail_sender = GmailSender.new("me", "password", FakedNetSMTP)
    gmail_sender.send(:to => "someone@somehost.com", :subject => "hi!", :content => "ho")
    FakedNetSMTP.sent_email
  end

  expect "From: me@somehost.com\nTo: someone@someotherhost.com\nSubject: hi!\nMIME-Version: 1.0\nContent-Type: text/plain; charset='utf-8'\n\nho\n" do
    gmail_sender = GmailSender.new("me@somehost.com", "password", FakedNetSMTP)
    gmail_sender.send(:to => "someone@someotherhost.com", :subject => "hi!", :content => "ho")
    FakedNetSMTP.sent_email
  end

  expect "From: me@somehost.com\nTo: someone@someotherhost.com,someone2@someotherhost.com\nSubject: hi!\nMIME-Version: 1.0\nContent-Type: text/plain; charset='utf-8'\n\nho\n" do
    gmail_sender = GmailSender.new("me@somehost.com", "password", FakedNetSMTP)
    gmail_sender.send(:to => ["someone@someotherhost.com", "someone2@someotherhost.com"], :subject => "hi!", :content => "ho")
    FakedNetSMTP.sent_email
  end

  expect GmailSender::Error do
    gmail_sender = GmailSender.new("me@somehost.com", "password", FakedNetSMTP)
    gmail_sender.send(:subject => "hi!", :content => "ho")
  end
end
