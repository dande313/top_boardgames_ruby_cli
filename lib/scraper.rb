require 'open-uri'
require 'openssl'
require 'pry'
require 'nokogiri'

class Scraper

  	@@info_arr = []

  def self.scrape_index_page(index_url)
    info_arr = []
    info={}
    styled_info= []
    index_html = Nokogiri::HTML(open(index_url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE))
	    index_html.css("tr#row_").each do |game|
	      info = {
		    :name => game.css("td.collection_objectname a").text.strip,
		    :year => game.css("td.collection_objectname span").text.strip,
	        :rank => game.css("td.collection_rank").text.strip,
	        :rating => game.css("td.collection_bggrating:first-of-type").text.strip,
	        :price => game.css("td.collection_shop a.ulprice:first-of-type span.positive").text.strip
        	}
	      @@info_arr << info
	      if @@info_arr.length == 10
	      	break
	      end
	    end
	    @@info_arr.each do |game_info|
			styled_info<< ["#{game_info[:rank]}. #{game_info[:name]} - #{game_info[:year]} - #{game_info[:rating].to_f.round(1).to_s}/10"]
		end

    return styled_info
  end

  def self.info_arr
  	@@info_arr
  end



end
