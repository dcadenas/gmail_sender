class GmailSender
  module Utils
    def self.blank?(string_or_array)
      string_or_array.nil? ||
      string_or_array.respond_to?(:strip) && string_or_array.strip == "" ||
      string_or_array.respond_to?(:empty?) && string_or_array.empty?
    end
  end
end
