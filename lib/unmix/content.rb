require "nokogiri"
module Unmix
  class Content
    # https://developer.mozilla.org/en-US/docs/Web/Security/Mixed_content
    # possible tag/attribute pairs that could contain mixed content
    MIXED_CONTENT_LOCATIONS = [
      # passsive
      %w(img src),
      %w(audio src),
      %w(video src),
      # active
      %w(script src),
      %w(link href),
      %w(iframe src),
      %w(object data),
    ]

    def initialize(html_string)
      @html_string = html_string
      @mixed_content = []
    end

    def mixed?
      return false if no_http_urls?
    end

    def find_and_fix_mixed_content
      MIXED_CONTENT_LOCATIONS.each do |tag, attribute|
        find_tags_with_http_url_attribute(tag, attribute).each do |node|
          url = node[attribute]
          https_url = url.sub("http://", "https://")
          puts "found http #{url} in #{tag} at #{attribute}"
          if valid_https?(https_url)
            node[attribute] = https_url
          end
        end
      end
      @doc.to_s
    end

    def find_tags_with_http_url_attribute(tag, attribute)
      css_selector = %{#{tag}[#{attribute}^="http://"]}
      doc.css(css_selector)
    end

    def no_http_urls?
      !@html_string.include?("http://")
    end

    def valid_https?(url)
      SslChecker.valid_cert?(url)
    end

    def doc
      @doc ||= Nokogiri::HTML::DocumentFragment.parse(@html_string)
    end
  end
end
