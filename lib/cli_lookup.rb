class Lookup
	attr_accessor



	def initialize
		@@index_data = Scraper.scrape_index_page("https://boardgamegeek.com/browse/boardgame") 
	end

    def clear_screen
    	puts "\e[H\e[2J"
    end

	def introduction
		puts ""
	    puts "************* Top 20 Highest Rated Board Games *************"
	    puts "                           v.2                             "
	    puts "                     by Allen Anderson                      "
	    puts ""
	    puts ""
	end

	def index_data
		@@index_data
	end



	def run
		clear_screen
		introduction
		puts
		index_data.each do |game_info|
			puts game_info
		end
		puts
		puts 'For more information on a particular game, please enter rank number. Otherwise, press "enter" to exit the CLI.'
		get_input
	end

	def get_input
		input = gets.strip
		if input.to_i >= 1  && input.to_i <= 20
			lookup_game(input.to_i)
		else
			clear_screen
			exit
		end
	end

	def lookup_game(input)
		game_url = Scraper.info_arr[input - 1][:page]
		game_data = Scraper.scrape_game_page(game_url, input - 1)
		clear_screen
		puts game_data[:name]
		puts game_data[:year]
		puts
		puts game_data[:description]
		puts
		puts "Press Enter to return"
		gets
		run
	end


end