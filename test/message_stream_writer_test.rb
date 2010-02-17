require 'test_helper'

Expectations do
  expect "From: sender@gmail.com\nTo: to@gmail.com\nSubject: subject\n\nbody\n" do
    string_io = StringIO.new
    message_stream_writer = GmailSender::MessageStreamWriter.new("sender@gmail.com")
    message_stream_writer.write(string_io, "to@gmail.com", "subject", "body")
    string_io.string
  end

  expect eval(<<-MAIL_WITH_ATTACHMENT_REGEXP) do
/From: sender@gmail.com
To: to@gmail.com
Subject: subject
MIME-Version: 1.0
Content-Type: multipart\\/mixed; boundary="([a-f0-9]+)"

--\\1
Content-Type: text\\/plain
body
--\\1
Content-Type: application\\/octet-stream; name="first_file.txt"
Content-Disposition: attachment; filename="first_file.txt"
Content-Transfer-Encoding: base64
Content-ID: <first_file.txt>

dGhpcyBpcyB0aGUgZmlyc3QgZmlsZSBjb250ZW50
--\\1
Content-Type: application\\/octet-stream; name="second_file.txt"
Content-Disposition: attachment; filename="second_file.txt"
Content-Transfer-Encoding: base64
Content-ID: <second_file.txt>

YW5kIHRoaXMgaXMgdGhlIHNlY29uZCBmaWxlIGNvbnRlbnQ=
/
MAIL_WITH_ATTACHMENT_REGEXP
    string_io = StringIO.new
    message_stream_writer = GmailSender::MessageStreamWriter.new("sender@gmail.com")
    message_stream_writer.attachments << "first_file.txt"
    message_stream_writer.attachments << "second_file.txt"

    with_files("first_file.txt" => "this is the first file content", "second_file.txt" => "and this is the second file content") do
      message_stream_writer.write(string_io, "to@gmail.com", "subject", "body")
    end

    string_io.string
  end
end
