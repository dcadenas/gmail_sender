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

  def send(to, subject, content)
    @net_smtp.start(@sender_domain, @sender_email, @sender_password, :plain) do |smtp|
      smtp.open_message_stream(@sender_email, [to]) do |msg|
        puts_headers(msg, to, subject)
        msg.puts content
        attach_files(msg)
      end
    end
  end

  # does not used
  def create_message(to, subject, content)
<<MSG
From: #@sender_email
To: #{to}
Subject: #{subject}

#{content}
MSG
  end

  private

  def puts_headers(msg, to, subject)
    msg.puts "From: #{@sender_email}"
    msg.puts "To: #{to}"
    msg.puts "Subject: #{subject}"
    unless @attachments.empty?
      msg.puts 'MIME-Version: 1.0'
      msg.puts %{Content-Type: multipart/mixed; boundary="#{@boundary}"}
    end
    msg.puts
    unless @attachments.empty?
      msg.puts "--#{@boundary}"
      msg.puts 'Content-Type: text/plain'
    end
  end

  def attach_files(msg)
    @attachments.each do |file|
      msg.puts "--#{@boundary}"
      msg.puts %{Content-Type: application/octet-stream; name="#{File.basename(file)}"}
      msg.puts %{Content-Disposition: attachment; filename="#{File.basename(file)}"}
      msg.puts 'Content-Transfer-Encoding: base64'
      msg.puts "Content-ID: <#{File.basename(file)}>"
      msg.puts
      File.open(file) do |fd|
        msg.puts Base64.encode64(fd.read(ATTACHMENT_READ_PORTION)) until fd.eof?
      end
    end
  end
end
