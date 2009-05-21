require "net/smtp"

class GmailSender
  def initialize(gmail_user, gmail_password)
    @gmail_user = "#{gmail_user}@gmail.com"
    @gmail_password = gmail_password
  end

  def create_message(to, subject, content)
<<MSG
From: #@gmail_user
To: #{to}
Subject: #{subject}

#{content}
MSG
  end

  def send(to, subject, content)
    net_smtp = Net::SMTP.new("smtp.gmail.com", 587)
    net_smtp.enable_starttls 
    net_smtp.start("gmail.com", @gmail_user, @gmail_password, :plain) do |smtp|
      msg = create_message(to, subject, content)
      smtp.send_message(msg, @gmail_user, to)
    end
  end
end

