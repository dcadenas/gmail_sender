require "tls_smtp_patch"

class GmailSender
  def initialize(gmail_user, gmail_password)
    @gmail_user = "#{gmail_user}@gmail.com"
    @gmail_password = gmail_password
    @net_smtp = Net::SMTP.new("smtp.gmail.com", 587)
    @net_smtp.enable_starttls 
  end

  def send(to, subject, content)
    @net_smtp.start("gmail.com", @gmail_user, @gmail_password, :plain) do |smtp|
      msg = create_message(to, subject, content)
      smtp.send_message(msg, @gmail_user, to)
    end
  end

  def create_message(to, subject, content)
<<MSG
From: #@gmail_user
To: #{to}
Subject: #{subject}

#{content}
MSG
  end
end

