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
		data.each do |game_info|
			puts game_info
		end
		puts
		puts 'For more information on a particular game, please enter rank number. To exit the CLI, type "exit".'
		input = gets.chomp
		exit
	end


end