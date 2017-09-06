class Game
	attr_accessor :name, :rank, :year, :rating, :page, :description

	@@all = []
	def initialize(name, rank, year, rating, page, description)
		@name = name 
		@rank = rank
		@year = year
		@rating = rating
		@page = page
		@description = description
		@@all << self
	end



	def self.all
		@@all
	end
end