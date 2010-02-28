class GmailSender
  module Utils
    def self.blank?(string)
      string.nil? || string.strip == ""
    end
  end
end
