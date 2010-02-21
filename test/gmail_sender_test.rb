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
  expect "From: me@gmail.com\nTo: someone@somehost.com\nSubject: hi!\n\nho\n" do
    gmail_sender = GmailSender.new("me", "password", FakedNetSMTP)
    gmail_sender.send("someone@somehost.com", "hi!", "ho")
    FakedNetSMTP.sent_email
  end

  expect "From: me@somehost.com\nTo: someone@someotherhost.com\nSubject: hi!\n\nho\n" do
    gmail_sender = GmailSender.new("me@somehost.com", "password", FakedNetSMTP)
    gmail_sender.send("someone@someotherhost.com", "hi!", "ho")
    FakedNetSMTP.sent_email
  end
end
