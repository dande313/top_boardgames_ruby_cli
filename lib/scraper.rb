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
    names = index_html.search("h4[itemprop='name'] a[itemprop='url']")

    #index_html.css("").each do |student|
      #info = {
 
      #}
      #info_arr << info
    #end

    return index_html
  end



end
