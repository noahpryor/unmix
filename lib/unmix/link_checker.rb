module Unmix
  module LinkChecker


    def self.mixed_content_link?(link)
       link.start_with?("http://")
    end

  end
end

