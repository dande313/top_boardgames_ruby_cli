require 'open-uri'
require 'openssl'
require 'pry'
require 'nokogiri'
require 'json'

class Scraper

  def self.scrape_index_page(index_url)
    index_html = Nokogiri::HTML(open(index_url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE))
    index_html.css("tr#row_")[0..19].each do |game|
	    game_name = game.css("td.collection_objectname a").text.strip
	    year = game.css("td.collection_objectname span").text.strip
      rank = game.css("td.collection_rank").text.strip
      rating = game.css("td.collection_bggrating:first-of-type").text.strip
      page = "https://boardgamegeek.com" + game.css("td.collection_objectname a[@href]").attribute('href')
      #token = game.css("td.collection_objectname a[@href]").attribute('href').to_s.gsub(/[^0-9,.]/, "")
      description = self.scrape_game_page("https://boardgamegeek.com" + game.css("td.collection_objectname a[@href]").attribute('href'))
      Game.new(game_name, rank, year, rating, page, description)
    end
  end

  def self.scrape_game_page(game_url)
  	game_html = Nokogiri::HTML(open(game_url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE))
  	description = game_html.css("meta[@name='description']").attribute('content').to_s.strip.gsub("\n", " ").gsub("&amp;", "&").gsub("&quot;", '"').gsub("&quot;", '"').gsub("&ldquo;", '"').gsub("&rdquo;", '"')
  	return description	
  end

end
