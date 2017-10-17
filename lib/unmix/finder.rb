require "nokogiri"

# handles interacting with the html document
module Unmix
  module Finder

    # https://developer.mozilla.org/en-US/docs/Web/Security/Mixed_content
    # Possible tags and attributes containing mixed content
    LOCATIONS = [
      {:tag=>"img", :attribute=>"src"},
      {:tag=>"audio", :attribute=>"src"},
      {:tag=>"video", :attribute=>"src"},
      {:tag=>"script", :attribute=>"src"},
      {:tag=>"link", :attribute=>"href"},
      {:tag=>"iframe", :attribute=>"src"},
      {:tag=>"object", :attribute=>"data"}
    ]

    def self.get_url(element)
      location = location_for_element(element)
      element[location[:attribute]]
    end

    def self.update_url(element, url)
      location = location_for_element(element)
      element[location[:attribute]] = url
    end

    def self.mixed_content_elements(doc)
      doc.css(*selectors)
    end

    # Generates a css selector all tags with attributes that start with http://
    def self.selector_for_location(location)
      %{%{tag}[%{attribute}^="http://"]} % location
    end

    def self.selectors
      LOCATIONS.map { |location| selector_for_location(location) }
    end

    def self.location_for_element(element)
      LOCATIONS.find { |location| location[:tag] == element.name }
    end
  end
end
