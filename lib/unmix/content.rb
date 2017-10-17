require_relative "./finder"
module Unmix
  class Content
    # https://developer.mozilla.org/en-US/docs/Web/Security/Mixed_content
    # possible tag/attribute pairs that could contain mixed content


    def initialize(html_string)
      @html_string = html_string
    end

    def find_and_fix_mixed_content
      mixed_content.each do |element|
        http_url = Finder.get_url(element)
        https_url = http_url.sub("http://", "https://")
        if valid_https?(https_url)
          Finder.update_url(element, https_url)
        end
      end
      doc.to_s
    end

    def mixed_content
      Finder.mixed_content_elements(doc)
    end

    def no_http_urls?
      !@html_string.include?("http://")
    end

    def valid_https?(url)
      SslChecker.valid_cert?(url).first
    end

    def doc
      @doc ||= Nokogiri::HTML::DocumentFragment.parse(@html_string)
    end
  end
end
