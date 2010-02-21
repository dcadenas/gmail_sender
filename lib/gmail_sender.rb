require 'base64'
require 'tls_smtp_patch'
require 'gmail_sender/message_stream_writer'

class GmailSender
  def initialize(user_or_email, password, net_smtp_class = Net::SMTP, message_stream_writer_class = MessageStreamWriter)
    user, domain = user_or_email.split("@")
    @sender_domain = domain || "gmail.com"
    @sender_email = "#{user}@#{@sender_domain}"
    @sender_password = password

    @net_smtp = net_smtp_class.new("smtp.gmail.com", 587)
    @net_smtp.enable_starttls

    @message_stream_writer = message_stream_writer_class.new(@sender_email)
  end

  def attach(file)
    @message_stream_writer.attachments << file if File.exist?(file)
  end

  def send(to, subject = "", content = "")
    @net_smtp.start(@sender_domain, @sender_email, @sender_password, :plain) do |smtp|
      smtp.open_message_stream(@sender_email, [to]) do |msg_stream|
        @message_stream_writer.write(msg_stream, to, subject, content)
      end
    end
  end
end
