class Lookup
	attr_accessor



	def initialize
	end

    def clear_screen
    	puts "\e[H\e[2J"
    end

	def introduction
		puts ""
	    puts "************* Top 10 Highest Rated Board Games *************"
	    puts "                           v.01                             "
	    puts "                     by Allen Anderson                      "
	    puts ""
	    puts ""
	end




	def run
		clear_screen
		introduction
		data = Scraper.scrape_index_page("https://boardgamegeek.com/browse/boardgame") 
		puts "Here is the data you requested:"
		puts data
		exit
	end


end