require 'open-uri'
require 'openssl'
require 'pry'
require 'nokogiri'
require 'phantomjs'
require 'httparty'
require 'json'

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
	        :page => "https://boardgamegeek.com" + game.css("td.collection_objectname a[@href]").attribute('href'),
	        :token => game.css("td.collection_objectname a[@href]").attribute('href').to_s.gsub(/[^0-9,.]/, "")
        	}
	      @@info_arr << info
	      if @@info_arr.length == 20
	      	break
	      end
	    end
	    @@info_arr.each do |game_info|
			styled_info<< ["#{game_info[:rank]}. #{game_info[:name]} - #{game_info[:year]} - #{game_info[:rating].to_f.round(1).to_s}/10"]
		end

    return styled_info
  end

  def self.scrape_game_page(game_url, input)
  	game_html = Nokogiri::HTML(open(game_url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE))
    	game_info = {
  		 :name => @@info_arr[input][:name],
  		 :year => @@info_arr[input][:year],
  		 :description => game_html.css("meta[@name='description']").attribute('content').to_s.strip.gsub("\n", " ").gsub("&amp;", "&").gsub("&quot;", '"').gsub("&quot;", '"').gsub("&ldquo;", '"').gsub("&rdquo;", '"')
  	}
  	return game_info
  	
  end

  def self.info_arr
  	@@info_arr
  end



end
