require 'open-uri'
require 'openssl'
require 'pry'
require 'nokogiri'

class Scraper

  def initialize
  end

  def self.scrape_index_page(index_url)
    info_arr = []
    index_html = Nokogiri::HTML(open(index_url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE))
	    index_html.css("tr#row_").each do |game|
	      info = {
		    :name => game.css("td.collection_objectname a").text.strip,
		    :year => game.css("td.collection_objectname span").text.strip,
	        :rank => game.css("td.collection_rank").text.strip,
	        :rating => game.css("td.collection_bggrating:first-of-type").text.strip
        	}
	      info_arr << info
	      if info_arr.length == 10
	      	break
	      end
	    end


    return info_arr
  end



end
