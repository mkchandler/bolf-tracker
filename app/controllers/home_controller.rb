class HomeController < ApplicationController
	def index
        @current_month = Date.today
        @previous_month = Date.today - 1.month
        
        @current_month_players = Player.all

        @current_month_players.each do |p|
            p.calculate_fields(Date.today.year, Date.today.month)
        end
        
        @final_cur_month_players = @current_month_players.find_all { |p| p.num_of_games > 0 }
        @final_cur_month_players.sort! { |a,b| 
            (b.winning_pct <=> a.winning_pct).nonzero? || 
            (b.points_per_game <=> a.points_per_game).nonzero? ||
            (b.points <=> a.points) }
            
        @prev_month_players = Player.all
        
        @prev_month_players.each do |p|
            p.calculate_fields(@previous_month.year, @previous_month.month)
        end
        
        @final_prev_month_players = @prev_month_players.find_all { |p| p.num_of_games > 0 }
        @final_prev_month_players.sort! { |a,b| 
            (b.winning_pct <=> a.winning_pct).nonzero? || 
            (b.points_per_game <=> a.points_per_game).nonzero? ||
            (b.points <=> a.points) }
	end
end