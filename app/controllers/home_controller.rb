class HomeController < ApplicationController
	def index
		@games = Game.all
    @players = Player.all
    @players.sort! { |a,b| b.winning_pct <=> a.winning_pct }
	end
end