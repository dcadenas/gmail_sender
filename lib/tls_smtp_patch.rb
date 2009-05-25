require "net/smtp"

if !Net::SMTP.instance_methods.include?(:enable_starttls)
  require "tlsmail" 
  class Net::SMTP
    def enable_starttls
      enable_tls(OpenSSL::SSL::VERIFY_NONE)
    end
  end
end
