require "nokogiri"
module Unmix
  class Content
    def initialize(html_string)
      @html_string = html_string
    end

    def mixed?
      return false if no_http_urls?
    end
    #
    # [any_http_urls? check to see if there's any http links at all]
    # to short circuit parsing with nokogiri, since if there's no http links
    # there's deifnitely not mixed content
    # @return [Boolean] [true if there are http links, false if not]
    def no_http_urls?
      !html_string.include?("http://")
    end

    def doc
      @doc ||= Nokogiri::HTML::DocumentFragment.parse(html_string)
    end
  end
end
