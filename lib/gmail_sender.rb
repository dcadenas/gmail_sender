require 'base64'
require "tls_smtp_patch"

class GmailSender

  ATTACHMENT_READ_PORTION = 150360 # you may change this, but must be multiply to 3

  def initialize(user, password, domain="gmail.com")
    @sender_domain   = domain
    @sender_password = password
    @sender_email     = "#{user}@#{domain}"
    @net_smtp = Net::SMTP.new("smtp.gmail.com", 587)
    @net_smtp.enable_starttls
    @attachments = []
    @boundary = rand(2**256).to_s(16)
  end

  def attach(file)
    @attachments << file if File.exist?(file)
  end

  def send(to, subject = "", content = "")
    @net_smtp.start(@sender_domain, @sender_email, @sender_password, :plain) do |smtp|
      smtp.open_message_stream(@sender_email, [to]) do |msg_stream|
        set_message_stream(msg_stream, to, subject, content)
      end
    end
  end

  def set_message_stream(msg_stream, to, subject, content)
    set_headers(msg_stream, to, subject)
    set_content(msg_stream, content)
    set_attachments(msg_stream)
  end

private
  def set_headers(msg_stream, to, subject)
    msg_stream.puts "From: #{@sender_email}"
    msg_stream.puts "To: #{to}"
    msg_stream.puts "Subject: #{subject}"
    unless @attachments.empty?
      msg_stream.puts 'MIME-Version: 1.0'
      msg_stream.puts %{Content-Type: multipart/mixed; boundary="#{@boundary}"}
    end
    msg_stream.puts
    unless @attachments.empty?
      msg_stream.puts "--#{@boundary}"
      msg_stream.puts 'Content-Type: text/plain'
    end
  end

  def set_content(msg_stream, content)
    msg_stream.puts content
  end

  def set_attachments(msg_stream)
    @attachments.each do |file|
      msg_stream.puts "--#{@boundary}"
      msg_stream.puts %{Content-Type: application/octet-stream; name="#{File.basename(file)}"}
      msg_stream.puts %{Content-Disposition: attachment; filename="#{File.basename(file)}"}
      msg_stream.puts 'Content-Transfer-Encoding: base64'
      msg_stream.puts "Content-ID: <#{File.basename(file)}>"
      msg_stream.puts
      File.open(file) do |fd|
        msg_stream.puts Base64.encode64(fd.read(ATTACHMENT_READ_PORTION)) until fd.eof?
      end
    end
  end
end
