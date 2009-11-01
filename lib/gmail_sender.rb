require "tls_smtp_patch"

class GmailSender
  def initialize(user, password, domain="gmail.com")
    @sender_domain   = domain
    @sender_password = password
    @sender_email     = "#{user}@#{domain}"
    @net_smtp = Net::SMTP.new("smtp.gmail.com", 587)
    @net_smtp.enable_starttls 
  end

  def send(to, subject, content)
    @net_smtp.start(@sender_domain, @sender_email, @sender_password, :plain) do |smtp|
      msg = create_message(to, subject, content)
      smtp.send_message(msg, @sender_email, to)
    end
  end

  def create_message(to, subject, content)
<<MSG
From: #@sender_email
To: #{to}
Subject: #{subject}

#{content}
MSG
  end
end
