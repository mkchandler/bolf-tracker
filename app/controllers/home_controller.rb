class HomeController < ApplicationController
	def index
        @players = Player.all
        
        @players.each do |p|
            p.calculate_fields
        end
        
        @players.sort! { |a,b| 
            (b.winning_pct <=> a.winning_pct).nonzero? || 
            (b.points_per_game <=> a.points_per_game).nonzero? ||
            (b.points <=> a.points) }
	end
end