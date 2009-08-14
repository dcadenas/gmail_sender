require "tls_smtp_patch"

module Gmail
  class Emailer
    def initialize(user, password, domain="gmail.com")
      @domain   = domain
      @password = password
      @user     = "#{user}@#{domain}"
      @net_smtp = Net::SMTP.new("smtp.gmail.com", 587)
      @net_smtp.enable_starttls 
    end

    def send(to, subject, content)
      @net_smtp.start(@domain, @user, @password, :plain) do |smtp|
        msg = create_message(to, subject, content)
        smtp.send_message(msg, @user, to)
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
end
