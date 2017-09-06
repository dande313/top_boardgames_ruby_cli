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
		puts ""
		Game.all.each do |game|
			puts "#{game.rank} - #{game.name} - #{game.year} - #{game.rating.to_f.round(1).to_s}/10"
		end
		puts ""
		puts 'For more information on a particular game, please enter rank number. Otherwise, type "exit" to exit the CLI.'
		get_input
	end

	def get_input
		input = gets.strip
		if input.to_i >= 1  && input.to_i <= 20
			lookup_game(input.to_i)
		elsif input.downcase == "exit"	
			clear_screen
			exit
		else
			puts "Invalid Entry"
			get_input
		end
	end

	def lookup_game(input)
		clear_screen
		index = input - 1
		game = Game.all[index]
		puts game.name
		puts game.year
		puts
		puts game.description
		puts
		puts "For more information, visit #{game.page}"
		puts 
		puts
		puts "Press Enter to return"
		gets
		run
	end
end