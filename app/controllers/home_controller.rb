class HomeController < ApplicationController
	def index
		@games = Game.all
    @players = Player.all
    @players.sort! { |a,b| 
      (b.winning_pct <=> a.winning_pct).nonzero? || 
      (b.points_per_game <=> a.points_per_game).nonzero? ||
      (b.points <=> a.points) }
	end
end